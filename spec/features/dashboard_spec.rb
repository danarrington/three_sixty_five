require 'rails_helper'

feature 'Main Dashboard' do

  context 'a logged in user' do
    let(:user) {create(:user, total_distance: 100)}
    before {capybara_sign_in user}
    context 'with some runs' do
      before {create_list(:run, 20, user: user)}

      before {Timecop.freeze(DateTime.new(2015, 1, 25, 8))}
      after {Timecop.return}
      scenario 'should see their run data' do
        visit '/'

        within('.run-data-container') do
          expect(page).to have_content '20'
          expect(page).to have_content '25'
          expect(page).to have_content '.78' #265/340

        end


      end

    end


  end

end
