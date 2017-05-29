require 'rails_helper'

feature 'admin views list of users' do
  # As an admin
  # I want to view a list of users
  # So I can see who uses the site
  #
  # Acceptance criteria:
  # * I must be signed in
  # * My user role must be set as "admin"
  scenario 'admin successfully views list of users' do
    first_user = FactoryGirl.create(:user)
    second_user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:user, role: "admin")
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'
    click_link 'View Users'

    expect(page).to have_content(first_user.email)
    expect(page).to have_content(second_user.email)
  end

  scenario 'non-admin unable to view list of users' do

  end
end
