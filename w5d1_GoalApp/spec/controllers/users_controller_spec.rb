require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "UsersController#new" do
    it "Renders a new template" do
      get :new, user: {}
      expect(response).to render_template("new")
    end
  end

  describe "UsersController#create" do
    it "Creates a new user with valid params" do
      post :create, user: {username: "Jack", password: "sparrow123"}
      expect(response).to redirect_to(user_url(User.last))
    end

    it "Won't creates a user with invalid params " do
      post :create, user: {username: "Jack"}
      expect(response).to render_template("new")
    end

    it "Won't creates a user with invalid params " do
      post :create, user: {password: "sparrow123"}
      expect(response).to render_template("new")
    end
  end
end
