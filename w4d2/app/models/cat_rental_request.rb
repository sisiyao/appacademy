class CatRentalRequest < ActiveRecord::Base
  STATUS = ["PENDING", "APPROVED", "DENIED"]

  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: STATUS }
  validate :no_overlapping_approved_request
  validate :start_date_before_end_date

  belongs_to :cat

  def start_date_before_end_date
    return if start_date.nil? || end_date.nil?
    unless end_date > start_date
      errors[:base] << "Start date must be before end date."
    end
  end

  def overlapping_requests
    CatRentalRequest
      .where.not(id: self.id)
      .where(cat_id: cat_id)
      .where(<<-SQL, end_date, start_date)
         NOT( (start_date > ?) OR (end_date < ?) )
      SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def no_overlapping_approved_request
    return if self.denied?

    if overlapping_approved_requests.length > 0
      errors[:base] << "An approved request overlaps this request."
    end
  end

  def approve!
    return unless pending?
    
    CatRentalRequest.transaction do
      update(status: "APPROVED")
      overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

  def deny!
    update(status: "DENIED")
  end

  def denied?
    status == "DENIED"
  end

  def pending?
    status == "PENDING"
  end
end
