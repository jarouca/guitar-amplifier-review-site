require 'rails_helper'

feature 'user views list of reviews for a particular amplifier' do
  # As a user
  # I want to view a list of all reviews for a particular amplifier
  # So I can view them all
  #
  # Acceptance criteria:
  # * I do not need to be signed in
  # * I must be able to view the list of reviews on an amplifier's show page

  scenario 'user views list of reviews' do
    first_amp = FactoryGirl.create(:amplifier)
    first_review = FactoryGirl.create(:review, amplifier_id: first_amp.id)
    second_review = FactoryGirl.create(:review, amplifier_id: first_amp.id)
    third_review = FactoryGirl.create(:review, amplifier_id: first_amp.id)

    visit root_path
    click_link first_amp.manufacturer, first_amp.model

    expect(page).to have_content(first_review.body)
    expect(page).to have_content(second_review.body)
    expect(page).to have_content(third_review.body)
  end
end
