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

    it 'should set the name abbreviation' do
      user2 = create(:user, first_name: 'Bob', last_name: 'Johnson')
      expect(subject.users.first[:name]).to eq 'Bob J'
    end

    it 'should capitalize the names' do
      user2 = create(:user, first_name: 'bob', last_name: 'johnson')
      expect(subject.users.first[:name]).to eq 'Bob J'
    end

    context 'paging' do
      let!(:users) {create_list(:user, 25, :with_increasing_distance)}
      subject {Leaderboard.new(type, 2)}
      it 'should only return [per_page] results' do
        expect(subject.users.count).to eq Leaderboard::PER_PAGE
      end
      it 'should offset results when given a page' do
        expect(subject.users.first[:id]).not_to eq User.last.id #last factory user created has greatest distance
        expect(subject.users.first[:id]).to eq User.order(total_distance: :desc).offset(Leaderboard::PER_PAGE).first.id
      end
      it 'should return the number of pages' do
        expect(subject.pages).to eq 3 #20/7 rounded up
      end
    end
  end

  describe 'single types of runs' do
    let!(:user1) {create(:user, total_distance: 50)}
    let!(:user2) {create(:user, total_distance: 5, first_name: 'bob', last_name: 'jo')}
    describe 'walking only' do
      let!(:type) {:walk}
      it 'should set the distance to the walking distance' do
        user2.runs << create(:run, runtype: :walk, distance: 2.5)
        expect(subject.users.first[:distance]).to eq 2.5
      end

      it 'should sort by walking distance' do
        user2.runs << create(:run, runtype: :walk, distance: 2.5)
        user2.runs << create(:run, runtype: :walk, distance: 3.5)
        user1.runs <<  create(:run, runtype: :walk, distance: 4.5)
        expect(subject.users.first[:distance]).to eq 6
      end

      it 'should set the name abbreviation' do
        user2.runs << create(:run, runtype: :walk, distance: 2.5)
        expect(subject.users.first[:name]).to eq 'Bob J' 
      end

      context 'paging' do
        let!(:users) {create_list(:user, 20, :with_increasing_walking_distance)}
        subject {Leaderboard.new(type, 2)}


        it 'should only return [per_page] results' do
          expect(subject.users.count).to eq Leaderboard::PER_PAGE
        end

        it 'should offset results when given a page' do
          expect(subject.users.first[:id]).not_to eq User.last.id #last factory user created has greatest distance
        end
      end
    end

    describe 'biking only' do
      let!(:type) {:bike}
      it 'should set the distance to the biking distance' do
        user2.runs << create(:run, runtype: :bike, distance: 3.5)
        expect(subject.users.first[:distance]).to eq 3.5
      end
    end
  end
end
