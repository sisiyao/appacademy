require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "SessionController#new" do

    it "Renders Sign In form " do
      get :new, session:{}
      expect(response).to render_template("new")
    end

  end

  describe "SessionsController#logout" do
    before(:each) do
      session[:session_token] = User.create(username: "Janet", password: "Jackson").reset_token!
    end

    it "logouts of session" do
       delete :destroy
      expect(session[:session_token]).to eq(nil)
    end
  end

  describe "SessionsController#create" do
    before(:each) do
      User.create(username: "john", password: "smith123")
    end

    it "creates a new session" do
      post :create, user: { username: "john", password: "smith123"}
      expect(response).to redirect_to(user_url(User.last))
    end

    it "doesn't log in with invalid params" do
      post :create, user: { username: "john"}
      expect(response).to render_template("new")
    end
  end
end
