require 'rails_helper'

RSpec.describe Announcement, :type => :model do

  describe '#for_user' do
    let(:user) {create(:user, created_at: 5.days.ago)}
    subject {Announcement.for_user(user)}

    context 'user has not seen latest announcement' do
      let!(:announcement)  {create(:announcement)}
      it 'should return latest announcement' do
        expect(subject).to eq announcement
      end

      it 'should update the users last_announcement_id' do
        subject
        expect(user.last_announcement_id).to eq announcement.id
      end

    end

    context 'user has seen latest announcement' do
      let!(:announcement)  {create(:announcement, id: 2)}
      before { user.update_attribute(:last_announcement_id, 2)}
      it 'should return nil' do
        expect(subject).to be_nil
      end
    end

    context 'user was created since the last announcement was' do
      let!(:announcement)  {create(:announcement, id: 2, created_at:5.days.ago)}
      before { user.update_attribute(:created_at, 1.days.ago)}
      it 'should return nil' do
        expect(subject).to be_nil
      end

      it 'should update the users last_announcement_id' do
        subject
        expect(user.last_announcement_id).to eq announcement.id
      end
    end

    context 'no announcements' do
      it 'should return nil' do
        expect(subject).to be_nil
      end
    end
  end
end
