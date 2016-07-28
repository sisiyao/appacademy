require_relative "questions_database"
require_relative "users"
require_relative "questions"
require_relative "aaquestions"

class QuestionFollow < AaQuestions
  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        u.id, u.fname, u.lname
      FROM
        question_follows as q
      JOIN
        users as u ON q.user_id = u.id
      WHERE
        question_id = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        q.id, q.title, q.user_id
      FROM
        question_follows as qf
      JOIN
        questions as q ON qf.question_id = q.id
      WHERE
        qf.user_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        q.id, q.title, q.user_id
      FROM
        question_follows AS qf
      JOIN
        questions AS q ON q.id = qf.question_id
      GROUP BY
        q.id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL

    results.map { |result| Question.new(result) }
  end
end
