require_relative "questions_database"
require_relative "users"
require_relative "aaquestions"

class QuestionLike < AaQuestions
  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        u.id, u.fname, u.lname
      FROM
        users AS u
      JOIN
        question_likes AS ql
        ON u.id = ql.user_id
      WHERE
        ql.question_id = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def self.num_likes_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS count
      FROM
        question_likes
      WHERE
        question_id = ?
      GROUP BY
        question_id
    SQL

    return 0 if result.empty?
    result.first['count']
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        q.id, q.title, q.user_id
      FROM
        question_likes as ql
      JOIN
        questions as q ON ql.question_id = q.id
      WHERE
        ql.user_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        q.id, q.title, q.user_id
      FROM
        questions as q
      JOIN
        question_likes as ql ON ql.question_id = q.id
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
