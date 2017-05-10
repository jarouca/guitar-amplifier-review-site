require 'rails_helper'
  # As a prospective user
  # I want to create an account
  # So that I can post items and review them

feature 'user creates an account' do
  scenario 'user successfully creates an account' do
    visit '/users/sign_up'
    click_link 'Sign Up'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Your registration was successful, thank you.")
    expect(page).to have_content("Sign Out")
  end

  scenario 'required information is not supplied' do
    visit '/users/sign_up'
    click_link 'Sign Up'
    click_button "Sign Up"

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password confirmation does not match password' do
    visit '/users/sign_up'
    click_link 'Sign Up'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'assword'
    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
