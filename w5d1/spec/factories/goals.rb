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

FactoryGirl.define do
  factory :goal do
    
  end
end
