require 'rails_helper'

feature 'Signing Up' do

  scenario 'New User should be able to sign up' do
    visit '/'

    find('.signup-container').click_link 'Sign up'

    fill_in :user_first_name, with: 'Dan'
    fill_in :user_last_name, with: 'Arrington'
    fill_in :user_email, with: 'dan@dan.com'
    fill_in :user_password, with: 'dandandan'
    fill_in :user_password_confirmation, with: 'dandandan'

    click_button 'Sign up'

    expect(User.last.first_name).to eq 'Dan'
    expect(User.last.last_name).to eq 'Arrington'
    expect(User.last.email).to eq 'dan@dan.com'
  end
end

