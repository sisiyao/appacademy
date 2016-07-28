require_relative "questions_database"
require_relative "replies"
require_relative "questions"
require_relative "question_follows"
require_relative "question_likes"
require_relative "aaquestions"

class User < AaQuestions
  attr_accessor :fname, :lname

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_name(fname, lname)
    result = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    User.new(result.first)
  end

  def ask_question(title, body)
    q = Question.new({'title' => title, 'body' => body, 'user_id' => @id})
    q.save
  end

  def reply_question(question_id, body)
    r = Reply.new({ 'body' => body, 'question_id' => question_id, 'parent_id' => nil, 'user_id' => @id })
    r.save
  end

  def reply_to_reply(reply_id, body)
    question_id = Reply.find_by_id(reply_id).question_id
    r = Reply.new({ 'body' => body, 'question_id' => question_id, 'parent_id' => reply_id, 'user_id' => @id })
    r.save
  end

  # def save
  #   if @id.nil?
  #     insert
  #   else
  #     update
  #   end
  #
  #   self
  # end
  #
  # def insert
  #   QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
  #     INSERT INTO
  #       users (fname, lname)
  #     VALUES
  #       (?, ?)
  #   SQL
  #
  #   @id = QuestionsDatabase.instance.last_insert_row_id
  # end
  #
  # def update
  #   QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
  #     UPDATE
  #       users
  #     SET
  #       fname = ?, lname = ?
  #     WHERE
  #       id = ?
  #   SQL
  # end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    questions = authored_questions
    total_karma = questions.inject(0) { |acc, question| acc + question.num_likes }
    total_karma / questions.length.to_f
  end
end
