class Favorite < ActiveRecord::Base
  validates :fav_id, :fav_type, presence: true


  belongs_to :fav, polymorphic: true
end
