require 'rails_helper'

feature 'admin deletes amplifier' do

# As an admin
# I want delete an amplifier
# So I can administrate my site
#
# Acceptance criteria:
# * I must be signed in
# * My user role must be set as "admin"
  scenario 'admin successfully deletes amplifier' do
    amp = FactoryGirl.create(:amplifier, manufacturer: 'Fender', model: 'Princeton')
    admin = FactoryGirl.create(:user, role: "admin", email: "admin@admin")

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Sign In'
    click_link 'Fender, Princeton'
    click_link 'Delete Amplifier'

    expect(page).to_not have_content('Fender, Princeton')
    expect(page).to have_content('Amplifier deleted successfully')
  end

  scenario 'non admin unable to delete amplifier' do
    amp = FactoryGirl.create(:amplifier, manufacturer: 'Fender', model: 'Princeton')
    non_admin = FactoryGirl.create(:user)

    visit 'users/sign_in'
    click_link 'Sign In'
    fill_in 'Email', with: non_admin.email
    fill_in 'Password', with: non_admin.password
    click_button 'Sign In'
    click_link 'Fender, Princeton'

    expect(page).to_not have_content('Delete Amplifier')
  end


end
