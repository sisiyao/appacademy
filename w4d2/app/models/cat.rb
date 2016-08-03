class Cat < ActiveRecord::Base
  COLORS = [
    "brown",
    "black",
    "white",
    "orange"
  ]

  SEX = ["m", "f"]

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: SEX }

  has_many :cat_rental_requests, dependent: :destroy
end
