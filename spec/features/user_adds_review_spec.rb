require 'rails_helper'

feature 'user reviews an amplifier' do
  # As an authenticated user
  # I want to add a review for an amplifier
  # So others can read my review
  #
  # Acceptance criteria:
  # * I must be signed in to review an amplifier
  # * I must be able to submit a review from the amplifier's show page
  # * I must then be redirected to the amplifier's show page and see the review listed there

  scenario 'an authenticated user successfully submits a review' do
    user = FactoryGirl.create(:user)
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    amp = FactoryGirl.create(:amplifier, manufacturer: 'Fender', model: 'Princeton')
    visit root_path
    click_link 'Fender, Princeton'
    click_link 'Review Amplifier'
    fill_in 'Body', with: 'I agree with the description, this amp is great for recording, it breaks up wonderfully at lower levels'
    click_button 'Create Review'

    expect(page).to have_content('Review submitted successfully')
    expect(page).to have_content('I agree with the description, this amp is great for recording, it breaks up wonderfully at lower levels')
  end

  scenario 'an unauthenticated user is unable to submit a review' do
    amp = FactoryGirl.create(:amplifier, manufacturer: 'Fender', model: 'Princeton')
    visit root_path
    click_link 'Fender, Princeton'

    expect(page).to_not have_content('Review Amplifier')
  end
end
