require 'rails_helper'

feature 'Start new Year' do

  context 'an admin' do
    let(:user) {create(:user, :admin, total_distance: 100.5)}
    let!(:season) {create(:season, year: 2015)}
    let!(:run) {create(:run, user:user)}
    before {capybara_sign_in user}

    scenario 'should be able to access the restart page' do
      visit '/admin/restart'
      expect(current_path).to eq restart_path
    end

    scenario 'should be able to start a new year' do
      visit '/admin/restart'

      click_link 'Begin 2016 Season'

      user.reload
      expect(user.total_distance).to eq 0
      expect(Season.current_season.year).to eq 2016
    end
  end

  context 'a non-admin' do
    let(:user) {create(:user)}
    before {capybara_sign_in user}

    scenario 'should not be able to access the restart page' do
      visit '/admin/restart'
      expect(current_path).to eq user_root_path
    end
  end
end
