class User < ActiveRecord::Base
  validates :user_name, uniqueness: true, presence: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response

  def completed_polls_sql
    Poll.find_by_sql(<<-SQL)
      SELECT p.*
      FROM polls AS p
      LEFT JOIN questions AS q ON p.id = q.poll_id
      LEFT JOIN (
        SELECT a.id, a.question_id, r.user_id
        FROM responses AS r
        LEFT JOIN answer_choices AS a ON r.answer_choice_id = a.id
        WHERE r.user_id = #{self.id}
      ) AS ra ON ra.question_id = q.id
      GROUP BY p.id
      HAVING COUNT(q.id) = COUNT(ra.id)
    SQL
  end

  def completed_polls_ar
    AnswerChoice
      .select("answer_choices.*")
      .from("answer_choices")
      .joins("LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id")
      .where("responses.user_id = ?", self.id)

    # Poll
    #   .select("poll.*")
    #   .joins("LEFT JOIN questions ON polls.id = questions.poll_id")
    #   .group("polls.id")
    #   .having("COUNT(questions.id) = COUNT(ra.id)")
  end
end
