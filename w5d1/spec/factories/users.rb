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

FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    password "password123"
  end
end
