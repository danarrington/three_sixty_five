require 'rails_helper'

describe RunsController do

  describe 'POST #create' do
    let(:user) {create(:user, total_distance: 5)}
    let!(:season) {create(:season)}

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
end