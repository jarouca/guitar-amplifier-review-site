require 'rails_helper'

feature '' do
  # As auser
  # I want to view the details about an amplifier
  # So that I can get more information about it
  #
  # Acceptance criteria:
  # * I do not need to be signed in
  # * From the home page I should see the list of reviewed amplifiers and be able to click on an amplifier to view its show page, displaying the amplifier's manufacturer, model, and all other provided details

  scenario 'user views details of an amplifier' do
    first_amp = FactoryGirl.create(:amplifier, description: "Great little practice/recording amp, sounds great when you really crank it!")
    visit root_path
    click_link "Fender 1, Princeton 1"

    expect(page).to have_content(first_amp.manufacturer)
    expect(page).to have_content(first_amp.model)
    expect(page).to have_content(first_amp.speaker)
    expect(page).to have_content(first_amp.tube_set)
    expect(page).to have_content(first_amp.description)

  end
end
