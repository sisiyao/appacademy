# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  session_token   :string           not null
#  password_digest :string           not null
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#


class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :goals

  attr_reader :password

  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    digest = BCrypt::Password.create(password)
    self.password_digest = digest
  end

  def is_password?(password)
    digest = BCrypt::Password.new(self.password_digest)
    digest.is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def self.find_by_credentials(username, password)
    potential_user = User.find_by(username: username)
    return nil if potential_user.nil?
    return potential_user if potential_user.is_password?(password)
    nil
  end
end
