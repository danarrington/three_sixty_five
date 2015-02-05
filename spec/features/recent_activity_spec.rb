require 'rails_helper'

feature 'Recent Activity' do

  context 'a logged in user' do
    let(:user) {create(:user, total_distance: 113.5)}
    before {capybara_sign_in user}

    before {create(:run, user:user, distance: 2.3, runtype: :run)}
    scenario 'should see recently submitted runs' do
      visit '/'
      expect(page.find('.user-recent-activity')).to have_content '2.3'
    end

    context 'with many runs', js: true do
      before {create_list(:run, 17, user:user)}
      scenario 'should be able to page through their recent activity' do
        visit '/'
        within('.user-recent-activity') do
          expect(page).to have_selector('.paged-row', count:10)
          click_link('2')
          expect(page).to have_selector('.paged-row', count:8)
        end

      end
    end
  end
end
