class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token!

  has_many :subs,
    foreign_key: :moderator_id,
    class_name: :Sub

  has_many :votes, as: :voteable

  has_many :comments,
    foreign_key: :author_id

  attr_reader :password

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def self.generate_session_token
    token = SecureRandom.urlsafe_base64(32)
    while User.exists?(session_token: token)
      token = SecureRandom.urlsafe_base64(32)
    end
    token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    password_dig = BCrypt::Password.new(self.password_digest)
    password_dig.is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def ensure_session_token!
    self.session_token ||= User.generate_session_token
  end
end
