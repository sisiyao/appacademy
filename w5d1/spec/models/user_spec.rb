# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  session_token   :string           not null
#  password_digest :string           not null
#  username        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User::find_by_credentials" do
    it "finds user by username and password" do
      FactoryGirl.create(:user, username: "arnold")
      expect(User.find_by_credentials("arnold", "password123")).to be_truthy
    end
  end


  describe  "User validations" do
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_presence_of(:session_token)}
  end

  describe  "User association" do
    it {should have_many(:goals)}
  end

end
