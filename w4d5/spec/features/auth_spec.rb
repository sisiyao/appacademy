feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign up for Reddit!"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email:', :with => "test@email.com"
      fill_in 'Create a password:', :with => "biscuits"
      click_on "Create user"
    end

    scenario "redirects to subs index page after signup" do
      expect(page).to have_content("SubReddits")
    end

    scenario "shows email on the homepage after signup" do
      expect(page).to have_content("test@email.com")
    end
  end

  feature "with an invalid user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email:', :with => "test@email.com"
      click_on "Create user"
    end

    scenario "re-renders the signup page if an invalid user is given" do
      expect(page).to have_content("Sign up for Reddit!")
    end
  end

end
