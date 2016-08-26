class Bench < ActiveRecord::Base
  validates :lat, :lng, presence: true
end
