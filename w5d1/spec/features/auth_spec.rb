require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'Username' , with: "Aaron"
      fill_in 'Password' , with: 'password123'
      click_on 'Sign Up'
      expect(page).to have_content "Aaron"
    end
  end
end

feature "logging in" do
  User.create(username: "bob", password: "builder")
  before(:each) do
    visit new_session_url
    fill_in("Username", with: "bob")
    fill_in("Password", with: "builder")
    click_on "Sign In"
    # redirect_to user_url(User.last)
  end

  scenario "shows username on the homepage after login" do
    expect(page).to have_content("bob")
  end
end

feature "logging out" do


  scenario "begins with a logged out state" do
      visit new_session_url
      expect(page).not_to have_content("Sign Out")
  end
  #
  # scenario "doesn't show username on the homepage after logout" do
  #
  #
  # end

end
