class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true


  has_many :contacts, dependent: :destroy
  has_many :contact_shares, dependent: :destroy #contactshares that have been shared with me

  has_many :shared_contacts, #contacts that have been shared with me
    through: :contact_shares,
    source: :user

  

  has_many :comments, as: :someone
end
