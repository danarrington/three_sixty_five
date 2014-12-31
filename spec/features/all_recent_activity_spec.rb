require 'rails_helper'

feature 'All Recent Activity' do

  context 'a logged in user' do
    let(:user) {create(:user)}
    let!(:other_user) {create(:user)}
    let!(:other_run) {create(:run, user:other_user, distance: 3.1, runtype: :walk)}
    before {capybara_sign_in user}

    before {Run.create(user:user, distance: 2.3, runtype: :run)}
    scenario 'should see all recently submitted runs' do
      visit '/'
      expect(page.find('.all-recent-activity')).to have_content '2.3'
      expect(page.find('.all-recent-activity')).to have_content '3.1'
    end
  end
end
