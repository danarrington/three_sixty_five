require 'rails_helper'

describe Leaderboard do

  subject {Leaderboard.new(type)}

  describe 'total distance' do
    let!(:type) {:total}
    it 'should sort by total distance' do
      user1 = create(:user, total_distance: 3.2)
      user2 = create(:user, total_distance: 45.3)
      user3 = create(:user, total_distance: 25.3)

      expect(subject.users.first[:distance]).to eq 45.3
    end
  end

  describe 'single types of runs' do
    let!(:user1) {create(:user, total_distance: 50)}
    let!(:user2) {create(:user, total_distance: 5)}
    describe 'walking only' do
      let!(:type) {:walk}
      it 'should set the distance to the walking distance' do
        user2.runs.create(runtype: :walk, distance: 2.5)
        expect(subject.users.first[:distance]).to eq 2.5
      end

      it 'should sort by walking distance' do
        user2.runs.create(runtype: :walk, distance: 2.5)
        user2.runs.create(runtype: :walk, distance: 3.5)
        user1.runs.create(runtype: :walk, distance: 4.5)
        expect(subject.users.first[:distance]).to eq 6

      end
    end
    describe 'biking only' do
      let!(:type) {:bike}
      it 'should set the distance to the biking distance' do
        user2.runs.create(runtype: :bike, distance: 3.5)
        expect(subject.users.first[:distance]).to eq 3.5
      end
    end
  end
end