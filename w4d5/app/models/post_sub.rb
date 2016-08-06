class PostSub < ActiveRecord::Base
  validates :post, uniqueness: { scope: :sub }
  validates :post, :sub, presence: true

  belongs_to :post

  belongs_to :sub
end
