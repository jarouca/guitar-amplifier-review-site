require 'rails_helper'

feature 'user deletes a review' do
  # As an authenticated user
  # I want to be able to delete my review
  # So I can remove if I desire to
  #
  # Acceptance criteria:
  # * I need to be signed in and I can only delete reviews that I submitted
  # * I must be able to access the delete link from the amplifier's show page

  scenario 'authenticated user deletes review' do
    user = FactoryGirl.create(:user)
    amp = FactoryGirl.create(:amplifier, user_id: user.id)
    review = FactoryGirl.create(:review, amplifier_id: amp.id, user_id: user.id)
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link amp.manufacturer, amp.model
    click_link 'Delete Review'

    expect(page).to have_content('Review deleted successfully')
  end

  scenario 'unathenticated user unable to delete review' do
    amp = FactoryGirl.create(:amplifier)
    review = FactoryGirl.create(:review, amplifier_id: amp.id)
    visit root_path
    click_link amp.manufacturer, amp.model

    expect(page).to_not have_content('Delete Review')
  end
end
