require 'rails_helper'

feature 'user changes their vote' do
  # As an authenticated user
  # I want to change my vote
  # In case I change my mind
  #
  # Acceptance criteria:
  # * I must be signed in
  # * I can only change my own vote

  scenario 'user changes up vote to down vote' do
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

    expect(page).to have_content('Up Votes: 1')
    expect(page).to have_content('Down Votes: 0')

    click_button 'Down Vote'

    expect(page).to have_content('Up Votes: 0')
    expect(page).to have_content('Down Votes: 1')
  end

  scenario 'user changes down vote to up vote' do
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
    click_button 'Down Vote'

    expect(page).to have_content('Down Votes: 1')
    expect(page).to have_content('Up Votes: 0')

    click_button 'Up Vote'

    expect(page).to have_content('Down Votes: 0')
    expect(page).to have_content('Up Votes: 1')
  end
end
