require 'rails_helper'

feature 'All Recent Activity' do

  context 'a logged in user' do
    let(:user) {create(:user)}
    let!(:other_user) {create(:user, 
      runs: create_list(:run, 10, run_date:1.day.ago))}
    let!(:other_run) {create(:run, user:other_user, distance: 3.1, runtype: :walk)}
    before {capybara_sign_in user}

    before {create(:run, user:user, distance: 2.3, runtype: :run)}
    scenario 'should see all recently submitted runs' do
      visit '/'
      expect(page.find('.all-recent-activity')).to have_content '2.3'
      expect(page.find('.all-recent-activity')).to have_content '3.1'
    end

    scenario 'should be able to page recent activity', js: true do
      visit '/'
      within('.all-recent-activity') do
        expect(page).to have_selector('.paged-row', count:10)
        click_link('2')
        expect(page).to have_selector('.paged-row', count:2)
      end
    end
  end
end
