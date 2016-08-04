class Album < ActiveRecord::Base
  RECORD_TYPE = %w(live studio)
  validates :band_id, :title, :record_type, presence: true
  validates :record_type, inclusion: RECORD_TYPE

  belongs_to :band

  has_many :tracks, dependent: :destroy
end
