require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  include SecureRandom

  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :user

  def self.random_code
    loop do
      url = SecureRandom.base64(16)
      return url unless self.exists?(short_url: url)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    url = self.random_code
    ShortenedUrl.create!(user_id: user.id, short_url: url, long_url: long_url)
  end

  def num_clicks
    ShortenedUrl.count_by_sql(<<-SQL)
      SELECT
        COUNT(*)
      FROM
        visits
      WHERE
        visits.shortened_url_id = #{self.id}
    SQL
  end

  def num_uniques
    ShortenedUrl.count_by_sql(<<-SQL)
      SELECT
        COUNT(DISTINCT user_id)
      FROM
        visits
      WHERE
        visits.shortened_url_id = #{self.id}
    SQL
  end

  def num_recent_uniques
    time = "'#{10.minutes.ago}'"
    ShortenedUrl.count_by_sql(<<-SQL)
      SELECT
        COUNT(DISTINCT user_id)
      FROM
        visits
      WHERE
        visits.shortened_url_id = #{self.id}
      AND
        visits.updated_at >= #{time}
    SQL
  end

  def num_uniques_distinct
    visitors.count
  end


end
