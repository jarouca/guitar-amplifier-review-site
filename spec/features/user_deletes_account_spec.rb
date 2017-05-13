require 'rails_helper'


feature 'user deletes their account' do
  # As an authenticated user
  # I want to delete my account
  # So that my information is no longer retained by the app

  scenario 'authenticated user deletes account' do
    user = FactoryGirl.create(:user)
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'Edit Information'
    click_link 'Cancel my account'

    expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
  end

  scenario 'unathenticated user unable to delete account' do
    visit 'users/sign_in'

    expect(page).to_not have_content('Cancel my account')
  end
end
