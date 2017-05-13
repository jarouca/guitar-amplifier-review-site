require 'rails_helper'

feature 'user adds an amplifier' do
  # As an authenticated user
  # I want to add an amplifier
  # So that others can review it

  # Acceptance criteria
  #
  # - I must be logged in to add an amplifier
  # - I must provide the manufacturer
  # - I must provide an amplifier model
  # - I may optionally provide the amplifier's speaker
  # - I my optionally provide the amplifier's tube set
  # - If I do not supply the required information I receive an error

  scenario 'user successfully adds an amplifier' do
    user = FactoryGirl.create(:user)
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    visit root_path
    click_link 'Add Amplifier'
    fill_in 'Manufacturer', with: 'Fender'
    fill_in 'Model', with: '5F2-A Princeton'
    fill_in 'Speaker', with: 'Jensen Alnico 8 inch'
    fill_in 'Tube Set', with: '5Y3, 6V6, 12AX7'

    click_button 'Submit Amplifier'
    expect(page).to have_content('Amplifier submitted for review, thank you.')
  end

  scenario 'user does not supply required information' do
    user = FactoryGirl.create(:user)
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    visit root_path
    click_link 'Add Amplifier'
    click_button 'Submit Amplifier'

    expect(page).to have_content("Manufacturer can't be blank")
    expect(page).to have_content("Model can't be blank")
  end
end
