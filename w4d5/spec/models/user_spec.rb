require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User model validations" do
    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:password_digest) }

    it do
      should validate_length_of(:password).
        is_at_least(6).
        on(:create)
    end
  end

  describe "User model associations" do
    it { should have_many(:subs) }

    it { should have_many(:votes) }

    it { should have_many(:comments) }
  end

  describe "User#is_password?" do
    subject(:user) { User.new(email: "sisi@gmail.com", password: "password") }

    it "returns true with the correct password" do
      expect(user.is_password?("password")).to be true
    end

    it "returns false with the wrong password" do
      expect(user.is_password?("password123")).to be false
    end
  end

  describe "User#reset_session_token" do
    subject(:user) { User.new(email: "sisiyao@gmail.com", password: "hellothere") }

    it "resets the session token" do
      current_token = user.session_token
      expect(current_token).to_not eq(user.reset_session_token!)
    end
  end

  describe "User::find_by_credentials" do
    it "finds the correct user" do
      user = User.create!(email: "charles@gmail.com", password: "catsanddogs")
      charles = User.find_by_credentials("charles@gmail.com", "catsanddogs")
      expect(charles).to eq(user)
    end

    it "returns nil if there no user is found" do
      sisi = User.find_by_credentials("sisi@gmail.com", "password")
      expect(sisi).to be(nil)
    end
  end
end
