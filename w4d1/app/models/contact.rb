class Contact < ActiveRecord::Base
  validates :name, :email, :user_id, presence: true
  validates :email, uniqueness: {scope: :user_id}

  belongs_to :user
  has_many :contact_shares

  has_many :shared_users, #set of users with whom a contact has been shared
    through: :contact_shares,
    source: :user

  has_many :comments, as: :someone
  has_many :favorites, as: :fav


  # has_many :favorites,
  #   through: :favorite_ids,
  #   source: :contact_or_contactshares
end
