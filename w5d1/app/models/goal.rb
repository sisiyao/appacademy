# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  content    :string           not null
#  user_id    :integer          not null
#  public     :boolean          default(TRUE), not null
#  completed  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ActiveRecord::Base
  validates :content, :user_id, presence: true
  validates :public_status, inclusion: { in: [true, false] }
  validates :completed, inclusion: { in: [true, false] }

  belongs_to :user
end
