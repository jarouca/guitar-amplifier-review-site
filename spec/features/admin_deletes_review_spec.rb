require 'rails_helper'

feature '' do
  # As an admin
  # I want to be able to delete a review
  # In case it violates the site's rules
  #
  # Acceptance criteria:
  # * I need to be signed in
  # * I must be an admin

  scenario 'admin successfully deletes review' do
    admin = FactoryGirl.create(:user, role: "admin", email: "admin@admin")
    amp = FactoryGirl.create(:amplifier)
    review = FactoryGirl.create(:review, amplifier_id: amp.id)
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'
    click_link amp.manufacturer, amp.model
    click_link 'Delete Review'

    expect(page).to have_content('Review deleted successfully')
  end
end
