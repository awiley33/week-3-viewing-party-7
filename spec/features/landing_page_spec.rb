require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")
    @user2 = User.create(name: "User Two", email: "user2@test.com", password: "password123", password_confirmation: "password123")
    visit root_path
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_link "Register as a User"
    
    expect(current_path).to eq(register_path) 

    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  describe "user is not logged in" do
    it "it has a link to log in or register" do
      expect(page).to have_link("Register as a User")
      expect(page).to have_link("Log In")

      click_link "Log In"

      expect(current_path).to eq(login_path)
    end

    it 'shows no info about existing users' do
      expect(page).to_not have_content('Existing Users:')
      expect(page).to_not have_content(@user1.email)
      expect(page).to_not have_content(@user2.email)
    end
  end

  describe "user is logged in" do
    it "it has a link to log out" do
      click_link "Log In"
      fill_in :email, with:'user1@test.com'
      fill_in :password, with: 'password123'
      click_button "Submit"
      visit root_path

      expect(page).to have_link("Log Out")

      click_link "Log Out"

      expect(current_path).to eq(root_path)

      expect(page).to_not have_link("Log Out")
      expect(page).to have_link("Log In")
    end

    it 'lists out existing users email addresses' do
      click_link "Log In"
      fill_in :email, with:'user1@test.com'
      fill_in :password, with: 'password123'
      click_button "Submit"
      visit root_path

      expect(page).to have_content('Existing Users:')
  
      within('.existing-users') do 
        expect(page).to have_content(@user1.email)
        expect(page).to have_content(@user2.email)
      end
    end
  end
end