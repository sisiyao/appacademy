require 'byebug'
require_relative 'questions_database'

class AaQuestions
  attr_reader :id

  TABLE_MAP = {
    'Reply' => 'replies',
    'User' => 'users',
    'Question' => 'questions',
    'QuestionLike' => 'question_likes',
    'QuestionFollow' => 'question_follows'
  }

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.class_string}
      WHERE
        id = ?
    SQL

    self.new(result.first)
  end

  def self.all
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.class_string}
    SQL

    results.map { |result| self.new(result) }
  end

  def save
    if @id.nil?
      insert
    else
      update
    end

    self
  end

  def insert
    var_string = self.instance_variables
    var_string.map! { |sym| sym.to_s[1..-1] }
    var_string = var_string.join(', ')

    vals = self.instance_variables
    vals.map! { |name| instance_variable_get(name) }

    qs = []
    vals.count.times do
      qs << '?'
    end
    qs = "(#{qs.join(', ')})"

    QuestionsDatabase.instance.execute(<<-SQL, *vals)
      INSERT INTO
        #{self.class.class_string} (#{var_string})
      VALUES
        #{qs}
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.class_string
    TABLE_MAP[self.to_s]
  end

  # def self.vars
  #   debugger
  #   instance_variables.map { |sym| sym.to_s[1..-1] }
  # end

  # def self.var_string
  #   self.vars.join(', ')
  # end

  # def val_array
  #   self.class.vars.map { |var_str| send(var_str.to_sym) }
  # end

  def self.question_string
    str = []
    self.instance_variables.count.times do
      str << '?'
    end
    "(#{str.join(', ')})"
  end
end
