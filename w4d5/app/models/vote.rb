
class Vote < ActiveRecord::Base

  validates :value, :voteable_id, :voteable_type, presence: true
  validates :value, inclusion: { in: [-1, 1], message: "Can only upvote and downvote once"}

  belongs_to :voteable, polymorphic: true

end
