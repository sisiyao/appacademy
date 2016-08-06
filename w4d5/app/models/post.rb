class Post < ActiveRecord::Base
  include Voteable

  validates :title, :sub_ids, :author_id, presence: true

  belongs_to :author,
    class_name: :User

  has_many :post_subs, dependent: :destroy, inverse_of: :post

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments

  def comments_by_parent_id
    comments_hash = Hash.new { |h, k| h[k] = [] }

    self.comments.each do |comment|
      comments_hash[comment.parent_comment_id] << comment
    end

    comments_hash
  end
end
