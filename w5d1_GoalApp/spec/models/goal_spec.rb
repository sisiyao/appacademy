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

require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe  "Goal validations" do
    it {should validate_presence_of(:content)}
    it {should validate_presence_of(:user_id)}
    it {should validate_inclusion_of(:public_status).in_array([true, false])}
    it {should validate_inclusion_of(:completed).in_array([true, false])}
  end

  describe  "Goal association" do
    it {should belong_to(:user)}
  end

end
