require 'rails_helper'

feature 'Logging Runs' do

  context 'a logged in user', js: true do
    let(:user) {create(:user, total_distance: 113.5)}
    before {capybara_sign_in user}

    scenario 'should be able to log a run' do
      click_link 'Log a run'
      fill_in :distance, with: 3
      click_link 'Submit'


      user.reload
      expect(user.total_distance).to eq 116.5
    end
  end
end