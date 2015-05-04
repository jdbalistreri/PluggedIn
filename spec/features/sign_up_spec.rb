require 'rails_helper'

feature "Signing up" do

  scenario "Sign up as a new user", js: true do
    visit '/users/new'
    fill_in 'user-fname', with: "Joe"
    fill_in 'user-lname', with: "Bali"
    fill_in 'user-email', with: "user@example.com"
    fill_in 'user-password', with: "password"
    click_button 'Sign Up'
    expect(page).to have_content "Welcome to Plugged In"
  end


end
