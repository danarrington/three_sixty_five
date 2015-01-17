require 'rails_helper'

describe HomeController do

  describe 'GET #user_recent_activity' do
    let!(:user) {create(:user, :with_a_run)}
    before {sign_in user}
    let!(:other_user) {create(:user, :with_a_run)}
    context 'with a user_id' do
      it 'should only return that users activity' do
        xhr :get, :user_recent_activity, user_id: 1, format: :js
        expect(assigns(:user_recent_activity).runs.count).to eq 1  
      end
    end

    context 'without a user_id' do
      it 'should return all users activity' do  
        xhr :get, :user_recent_activity, format: :js 
        expect(assigns(:user_recent_activity).runs.count).to eq 2  
      end
    end
  end

end
