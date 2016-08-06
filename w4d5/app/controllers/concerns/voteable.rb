module Voteable
  extend ActiveSupport::Concern


  included do
    has_many :votes, as: :voteable
  end

  def count_votes
    @count_votes ||= 0
  end

  def count_votes=(value)
    @count_votes ||= 0
    @count_votes += value
  end

end
