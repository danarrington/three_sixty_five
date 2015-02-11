require 'rails_helper'

describe RunsController do

  describe 'POST #create' do
    let(:user) {create(:user, total_distance: 5)}
    let!(:season) {create(:season)}
    before {Timecop.freeze}
    after {Timecop.return}

    context 'with signed in user' do
      before {sign_in user}

      context 'with valid attributes' do
        let(:attributes) {attributes_for(:run, distance: 2.34, runtype: 'run')}
        it 'should save the run' do
          expect{
            post :create, run: attributes
          }.to change(Run, :count).by 1
        end

        it 'assigns run to the signed in user' do
          post :create, run: attributes_for(:run)
          expect(Run.last.user).to eq user
        end

        it 'should set the run properties' do
          post :create, run: attributes
          r = Run.last
          expect(r.distance).to eq 2.34
          expect(r.season).to eq season
          expect(Run.runtypes[r.runtype]).to eq Run.runtypes[:run]
          expect(r.run_date.to_datetime.to_s).to eq DateTime.now.to_s
        end

        it 'should update the users total distance' do
          post :create, run: attributes
          user.reload
          expect(user.total_distance).to eq 7.34
        end
      end

      context 'with invalid attributes' do
        let(:attributes) {attributes_for(:run, distance: nil)}
        subject {post :create, run: attributes}

        it 'should redirect to index' do
          #where should this go?
        end

        it 'should set the status code to 422' do
          expect(subject.status).to eq 422
        end
      end
    end

    context 'with signed out user' do
      let(:attributes) {attributes_for(:run, distance: 2.34)}
      it 'should not save a run' do
        expect{post :create, run: attributes}.to change(Run, :count).by 0
      end
      it 'should redirect to root' do
        post :create, run: attributes
        expect(response).to redirect_to new_user_session_path
      end
    end

  end

  describe 'GET #index' do
    context 'with a signed out user' do
      it 'should redirect to root' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'with a signed in user' do
      let!(:user) {create(:user, :with_a_run)}
      let!(:other_user) {create(:user, :with_a_run)}
      before {sign_in user}
      it 'should list only that users runs' do
        get :index
        expect(assigns(:runs).count).to eq 1 
      end
    end
  end

  describe 'PUT #update' do
    let!(:user) {create(:user, total_distance: 23.1)}
    let!(:run) {create(:run, user:user, distance: 12.1, 
                       run_date: Date.today-5.days)}
    context 'with a signed out user' do 
      it 'should redirect to signin' do
        put :update, id: run.id
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'with a signed in user' do
      before {sign_in user}
      context 'with valid data' do
        it 'should update the run distance' do
          put :update, id: run.id, run: attributes_for(:run, distance: 1.21)
          run.reload
          expect(run.distance).to eq 1.21
        end

        it 'should update the users total distance' do
          post :update, id: run.id, run: attributes_for(:run, distance:3.1)
          user.reload
          expect(user.total_distance).to eq 3.1
        end

        it 'should update the run_date' do
          post :update, id: run.id, 
            run: attributes_for(:run, run_date:Date.yesterday.strftime('%-m/%-d'))
          run.reload
          expect(run.run_date.to_datetime).to eq DateTime.now.midnight-1.day
        end
      end

      context 'with invalid data' do
        it 'should return the right status' do
          post :update, id: run.id, run: attributes_for(:run, distance:'3.1.1')
          expect(response).to be_unprocessable
        end

        it 'should return the error' do
          post :update, id: run.id, run: attributes_for(:run, distance:'3.1.1')
          expect JSON.parse(response.body).count > 0
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) {create(:user, total_distance: 23.1)}
    let!(:run) {create(:run, user:user, distance: 12.1, 
                       run_date: Date.today-5.days)}
    let!(:other_run) {create(:run, user:create(:user))}
    context 'with a signed in user' do
      before {sign_in user}
      it 'should delete the run' do
        expect {
          delete :destroy, id: run
        }.to change(Run, :count).by(-1)
      end

      it 'should update the users total distance' do
        delete :destroy, id: run
        user.reload
        expect(user.total_distance).to eq 0.0
      end

      it 'should not allow you to delete someone elses run' do
        expect {
          delete :destroy, id: other_run
        }.to change(Run, :count).by(0)
      end

    end

  end
end
