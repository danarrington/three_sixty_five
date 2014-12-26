require 'rails_helper'

feature 'Logging Runs' do

  context 'a logged in user' do
    let(:user) {create(:user, total_distance: 113.5)}
    before {capybara_sign_in user}

    scenario 'should be able to log a run' do
      click_link 'Log your miles'
      fill_in :run_distance, with: 3.2
      click_button 'Submit'

      user.reload
      expect(user.total_distance).to eq 116.7
      run = Run.last
      expect(Run.runtypes[run.runtype]).to eq Run.runtypes[:run]
    end
  end
end