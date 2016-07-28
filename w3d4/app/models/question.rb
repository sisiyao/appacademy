class Question < ActiveRecord::Base
  validates :poll_id, :text, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def n_plus_one_results
    answers = answer_choices

    response_counts = {}
    answers.each do |answer_choice|
      response_counts[answer_choice.text] = answer_choice.responses.count
    end

    response_counts
  end

  def better_results
    answers = answer_choices.includes(:responses)

    response_counts = {}
    answers.each do |answer|
      response_counts[answer.text] = answer.responses.length
    end

    response_counts
  end

  def sql_results
    results = AnswerChoice.find_by_sql(<<-SQL)
      SELECT
        answer_choices.*, COUNT(responses.id) AS results_count
      FROM
        answer_choices
      LEFT JOIN
        responses ON answer_choices.id = responses.answer_choice_id
      WHERE
        answer_choices.question_id = #{self.id}
      GROUP BY
        answer_choices.id
    SQL

    answer = {}
    results.each do |result|
      answer[result.text] = result.results_count
    end

    answer
  end

  def active_record_results
    self.answer_choices
      .select("answer_choices.*, COUNT(responses.id) as results_count")
      .joins("LEFT OUTER JOIN responses on answer_choices.id = responses.answer_choice_id")
      .group("answer_choices.id")
  end

end
