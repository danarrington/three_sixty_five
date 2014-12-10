require 'rails_helper'

feature 'Recent Activity' do

  context 'a logged in user' do
    let(:user) {create(:user, total_distance: 113.5)}
    before {capybara_sign_in user}

    before {Run.create(user:user, distance: 2.3, runtype: :run)}
    scenario 'should see recently submitted runs' do
      visit '/'
      expect(page.find('.recent-activity')).to have_content '2.3'

    end
  end
end
