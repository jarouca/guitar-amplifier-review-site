require 'rails_helper'

feature 'user updates a review' do
  # As an authenticated user
  # I want to update my review
  # So I can make corrections and changes
  #
  # Acceptance criteria:
  # * I need to be signed in and I can only edit reviews that I submitted
  # * I must be able to access the update form from amplifier's show page

  scenario 'authenticated user successfully updates review' do
    user = FactoryGirl.create(:user)
    amp = FactoryGirl.create(:amplifier, user_id: user.id)
    review = FactoryGirl.create(:review, amplifier_id: amp.id, user_id: user.id)
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link amp.manufacturer, amp.model
    click_link 'Edit Review'
    fill_in 'Body', with: 'I love this amplifier, it is even loud enough to use in small clubs!'
    click_button 'Update Review'

    expect(page).to have_content('Review updated successfully')
    expect(page).to have_content('I love this amplifier, it is even loud enough to use in small clubs!')
    end

  scenario 'unathenticated user is unable to update review' do
    amp = FactoryGirl.create(:amplifier)
    review = FactoryGirl.create(:review, amplifier_id: amp.id)
    visit root_path
    click_link amp.manufacturer, amp.model

    expect(page).to_not have_content('Edit Review')
  end

  scenario 'required information is not provided' do
    user = FactoryGirl.create(:user)
    amp = FactoryGirl.create(:amplifier, user_id: user.id)
    review = FactoryGirl.create(:review, amplifier_id: amp.id, user_id: user.id)
    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link amp.manufacturer, amp.model
    click_link 'Edit Review'
    fill_in 'Body', with: ''
    click_button 'Update Review'

    expect(page).to have_content("Body can't be blank")
  end
end
