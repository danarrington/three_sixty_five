require 'rails_helper'

feature 'Edit Run Data', js:true do
  let(:user) {create(:user)}

  context 'a logged in user with previous entries' do
    let!(:too_long_run) {create(:run, user:user, distance:30)}
    let!(:wrong_type_run) {create(:run, user:user, distance:2.0, :runtype=>:swim)}
    let!(:wrong_date_run) {create(:run, user:user, run_date:'1/1/2015')}

    before {capybara_sign_in user}
    scenario 'should be able to edit the distance' do
      visit '/'
      click_link('Edit')

      click_link('30')
      find('input').set('3.0')
      find('.glyphicon-ok').click
      visit '/'
      expect(page).to have_content('3.0')
    end

    scenario 'should be able to edit the type' do
      visit '/'
      click_link('Edit')

      click_link('swim')
      find('select').find("option[value='walk']").select_option
      find('.glyphicon-ok').click
      visit '/'
      expect(page).to have_content('walk')
    end

    scenario 'should be able to edit the date' do
      visit '/'
      click_link('Edit')

      click_link('1/1')
      find("td.day", text: 21).click
      find('.glyphicon-ok').click

      visit '/'
      expect(page).to have_content('Jan 21')
    end

    scenario 'should be able to delete runs' do
      visit '/'
      click_link('Edit')

      within("tr[data-run-id='#{too_long_run.id}']") do
        find('.glyphicon-remove').click
      end
      click_link('Delete')

      visit '/'
      expect(page).to_not have_content('30')
    end

    context 'with many runs' do
      before {create_list(:run, 21, user:user)}

      scenario 'should be able to page through runs' do
        visit '/runs'
        expect(page).to have_selector('.page', count:3)
      end
    end
  end
end

                       

