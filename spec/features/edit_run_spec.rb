require 'rails_helper'

feature 'Edit Run Data' do
  let(:user) {create(:user)}

  context 'a logged in user with previous entries' do
    let!(:too_long_run) {create(:run, user:user, distance:30)}
    let!(:wrong_date_run) {create(:run, user:user, distance:2.0)}

    before {capybara_sign_in user}
    scenario 'should be able to edit the distance' do
      visit '/'
      click_link('Edit')

      find('.something').click_link('Edit').fill_in 'Distance', with: '3.0'
      click_link 'Submit'
      Visit '/'
      expect(page).to have_content('3.0')
    end
  end
end

                       

