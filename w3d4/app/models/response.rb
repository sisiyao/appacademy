class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response
  validate :not_own_poll?

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  has_one :question,
    through: :answer_choice,
    source: :question

  def not_duplicate_response
    if respondent_already_answered?
      errors[:respondent] << "can't respond more than once"
    end
  end

  def not_own_poll?
    if self.answer_choice.question.poll.author_id == self.user_id
      errors[:respondent] << "can't respond to own poll"
    end
  end

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    siblings = sibling_responses
    siblings.each do |sibling|
      if sibling.user_id == self.user_id
        return true
      end
    end
    false
  end

end
