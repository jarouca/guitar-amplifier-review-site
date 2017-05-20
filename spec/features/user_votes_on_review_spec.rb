require 'rails_helper'

feature 'user votes on a review' do
  # As an authenticated user
  # I want to upvote/downvote a review
  # So I can show what I like/dislike
  #
  # Acceptance criteria:
  # * I must be signed in
  # * I can only vote once

  scenario 'authenticated user upvotes a review' do
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
  end

  scenario 'authenticated user downvotes a review' do
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
  end

  scenario 'authenticated user unable to up vote twice' do
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

    page.should_not have_selector(:link_or_button, 'Up Vote')
  end

  scenario 'authenticated user unable to down vote twice' do
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

    page.should_not have_selector(:link_or_button, 'Down Vote')
  end

  scenario 'unathenticated user unable to vote on review' do
    amp = FactoryGirl.create(:amplifier)
    review = FactoryGirl.create(:review, amplifier_id: amp.id)
    visit root_path
    click_link amp.manufacturer, amp.model

    page.should_not have_selector(:link_or_button, 'Down Vote')
    page.should_not have_selector(:link_or_button, 'Up Vote')
  end
end
