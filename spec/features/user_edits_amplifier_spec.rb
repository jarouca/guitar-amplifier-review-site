require 'rails_helper'

feature 'user updates an amplifier' do
  # As an authenticated user
  # I want to update an amplifier's information
  # So that I can correct errors or provide new information
  #
  # Acceptance Criteria:
  # * I must be signed in to edit a submission
  # * I can only update my own amplifier submissions
  # * I must be able to access the update page from the amplifier's show page

  scenario 'user successfully updates a submission' do
    user = FactoryGirl.create(:user)
    amp = FactoryGirl.create(:amplifier, manufacturer: 'Fender', model: 'Princeton', user_id: user.id)

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'Fender, Princeton'
    click_link 'Edit Amplifier'
    fill_in 'Model', with: '5E3 Deluxe'
    fill_in 'Speaker', with: 'Jensen 12 inch Alnico'
    fill_in 'Tube Set', with: '5Y3, 6V6, 6V6, 12AX7, 12AX7'
    click_button 'Update Amplifier'

    expect(page).to have_content('Amplifier edited successfully')
    expect(page).to have_content('5E3 Deluxe')
    expect(page).to have_content('Jensen 12 inch Alnico')
    expect(page).to have_content('5Y3, 6V6, 6V6, 12AX7, 12AX7')
  end

  scenario 'user does not provide the required information' do
    user = FactoryGirl.create(:user)
    amp = FactoryGirl.create(:amplifier, manufacturer: 'Fender', model: 'Princeton', user_id: user.id)

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'Fender, Princeton'
    click_link 'Edit Amplifier'
    fill_in 'Manufacturer', with: ''
    fill_in 'Model', with: ''
    click_button 'Update Amplifier'

    expect(page).to have_content("Model can't be blank")
    expect(page).to have_content("Manufacturer can't be blank")
  end

  scenario "user is not able to update someone else's submission" do
    amp = FactoryGirl.create(:amplifier, manufacturer: 'Fender', model: 'Princeton')

    visit root_path
    click_link 'Fender, Princeton'

    expect(page).to_not have_content('Edit Amplifier')
  end
end
