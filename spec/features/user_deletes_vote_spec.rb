require 'rails_helper'

feature 'user deletes their vote' do
  # As an authenticated user
  # I want to delete my vote
  # In case I change my mind
  #
  # Acceptance criteria:
  # * I must be signed in
  # * I can only delete my own vote
  scenario 'authenticated user successfully deletes their own vote' do
    user = FactoryGirl.create(:user)
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    amp = FactoryGirl.create(:amplifier)
    review = FactoryGirl.create(:review, amplifier_id: amp.id)
    visit root_path
    click_link amp.manufacturer, amp.model
    click_button 'Up Vote'
    click_button 'Delete Vote'

    expect(page).to have_content('Up Votes: 0')
    expect(page).to have_content('Down Votes: 0')
  end
end
