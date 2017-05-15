require 'rails_helper'

feature 'user deletes an amplifier' do
  # As an authenticated user
  # I want to delete an amplifier
  # So that no one can review it
  #
  # Acceptance criteria:
  # * I must be signed in
  # * I must be able to access the delete feature from the amplifier's show page

  scenario 'authenticated user successfully deletes an amplifier' do
    user = FactoryGirl.create(:user)
    amp = FactoryGirl.create(:amplifier, manufacturer: 'Fender', model: 'Princeton', user_id: user.id)

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'Fender, Princeton'
    click_link 'Delete Amplifier'

    expect(page).to_not have_content('Fender, Princeton')
    expect(page).to have_content('Amplifier deleted successfully')
  end

  scenario "unathenticated user is unable to delete an amplifier"  do
    amp = FactoryGirl.create(:amplifier, manufacturer: 'Fender', model: 'Princeton')

    visit root_path
    click_link 'Fender, Princeton'

    expect(page).to_not have_content('Delete Amplifier')
  end
end
