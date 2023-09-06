require 'rails_helper'

RSpec.describe "Login Form" do
  before do
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")

    visit login_path
  end

  it "has fields for email and password and a submit button" do
    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
    expect(page).to have_button("Submit")
  end

  describe "successful login" do
    before do
      fill_in :email, with:'user1@test.com'
      fill_in :password, with: 'password123'
      click_button "Submit"
    end

    it "routes to user dashboard when good credentials are submitted" do
      expect(current_path).to eq(user_path(@user1.id))
    end

    it "displays a flash message welcoming the user by name" do
      expect(page).to have_content("Welcome, #{@user1.name}!")
    end
  end

  describe "unsuccessful login attempt" do
    before do
      fill_in :email, with:'user1@test.com'
      fill_in :password, with: 'wrong'
      click_button "Submit"
    end

    it "reroutes to login page when bad credentials are submitted" do
      expect(current_path).to eq(login_path)
    end

    it "displays a flash message notifying the user" do
      expect(page).to have_content("You entered incorrect credentials.")
    end
  end
end