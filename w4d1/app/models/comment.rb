class Comment < ActiveRecord::Base
  validates :body, presence: true

  belongs_to :someone, polymorphic: true
end
