require 'rails_helper'

describe RecentUserActivity do

  let(:user) {create(:user)}

  context 'for a user' do
    subject {RecentUserActivity.new(user)}
    context 'with no extra parameters' do
      let!(:runs) {create_list(:run, 5, user_id: user.id)}
      it 'should return recent runs for user' do
        expect(subject.runs.count).to eq 5
      end

      it 'should sort them by date' do
        early_run = create(:run, created_at:3.days.ago, user_id: user.id)
        expect(subject.runs.last.id).to eq early_run.id
      end

      context 'with many runs' do
        let!(:runs) {create_list(:run, 20, user_id: user.id)}
        it 'should return last 10 runs' do
          expect(subject.runs.count).to eq 10
        end
      end
    end
  end

  context 'when not given a user' do
    subject {RecentUserActivity.new()}
    let!(:user1) {create(:user, :with_a_run)}
    let!(:user2) {create(:user, :with_a_run)}
    it 'should return all recent activity' do
      expect(subject.runs.count).to eq 2 
    end
  end
end
