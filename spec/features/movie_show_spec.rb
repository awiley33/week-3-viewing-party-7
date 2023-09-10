require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  before do 
    @user1 = User.create(name: "User One", email: "user1@test.com", password: "password123", password_confirmation: "password123")
    i = 1
    20.times do 
      Movie.create(title: "Movie #{i} Title", rating: rand(1..10), description: "This is a description about Movie #{i}")
      i+=1
    end
  end 

  it 'shows all movies' do 
    visit root_path
    click_link "Log In"
    fill_in :email, with:'user1@test.com'
    fill_in :password, with: 'password123'
    click_button "Submit"

    visit "users/#{@user1.id}"

    click_button "Find Top Rated Movies"

    expect(current_path).to eq("/users/#{@user1.id}/movies")

    expect(page).to have_content("Top Rated Movies")
    
    movie_1 = Movie.first

    click_link(movie_1.title)

    expect(current_path).to eq("/users/#{@user1.id}/movies/#{movie_1.id}")

    expect(page).to have_content(movie_1.title)
    expect(page).to have_content(movie_1.description)
    expect(page).to have_content(movie_1.rating)
  end

  describe "unregistered user clicks button to create viewing party" do
    it "redirects to movie show page and displays flash message" do
      movie_1 = Movie.first
      visit "/users/#{@user1.id}/movies/#{movie_1.id}"
      click_button "Create a Viewing Party"
      save_and_open_page
      expect(page).to have_content("You must be registered and logged in to create a viewing party.")
    end
  end
end