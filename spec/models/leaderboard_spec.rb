require 'rails_helper'

describe Leaderboard do

  subject {Leaderboard.new}

  describe 'total distance' do
    it 'should sort by total distance' do
      user1 = create(:user, total_distance: 3.2)
      user2 = create(:user, total_distance: 45.3)
      user3 = create(:user, total_distance: 25.3)

      expect(subject.total_distance.first[:total_distance]).to eq 45.3
    end
  end
end