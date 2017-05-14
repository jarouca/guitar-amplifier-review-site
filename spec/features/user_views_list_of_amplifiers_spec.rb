require 'rails_helper'

feature 'user views a list of all amplifiers submitted for review' do
  # As a user
  # I want to view a list of amplifier manufacturers and models
  # So that I can pick items to review
  # I do not need to be authenticated to view a list of amplifiers

  # Acceptance criteria:
  # I do not need to be signed in to view the list of amplifiers
  # The most recently submitted amplifiers appear at the top of the list

  scenario 'user successfully views list of amplifiers' do
    first_amp = FactoryGirl.create(:amplifier)
    second_amp = FactoryGirl.create(:amplifier)
    third_amp = FactoryGirl.create(:amplifier)
    fourth_amp = FactoryGirl.create(:amplifier)

    visit "/amplifiers"

    expect(page).to have_content(first_amp.manufacturer)
    expect(page).to have_content(first_amp.model)
    expect(page).to have_content(second_amp.manufacturer)
    expect(page).to have_content(second_amp.model)
    expect(page).to have_content(third_amp.manufacturer)
    expect(page).to have_content(third_amp.model)
  end
end
