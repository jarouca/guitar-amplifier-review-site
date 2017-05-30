require 'rails_helper'

feature 'admin deletes user' do
  # As an admin
  # I want delete a user
  # So I can administrate my site
  #
  # Acceptance criteria:
  # * I must be signed in
  # * My user role must be set as "admin"
  scenario 'admin deletes user' do
    first_user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:user, role: "admin", email: "admin@admin")
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'
    click_link 'View Users'
    click_button 'Delete User'
    
    expect(page).to have_content('User successfully deleted')
  end
end
