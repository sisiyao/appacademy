class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many :shortened_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl

  has_many :visits,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Visit

  has_many :visited_urls,
    -> { distinct },
    through: :visits,
    source: :shortened_url

    def visited_urls_distinct
      visited_urls.count
      # self.visited_urls { self.visits.shortened_url_id }
      # self.visited_urls { shortened_urls }
    end
end
