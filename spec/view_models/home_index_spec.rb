require 'spec_helper' 

describe HomeIndex do

  subject {HomeIndex.new(user)}

  describe '#new' do
    let(:user) {create(:user, :with_a_run, total_distance: 25)}
    before {Timecop.freeze(Time.local(2015, 1, 30))}
    after {Timecop.return}

    it 'should set the user' do
      expect(subject.user).to be user
    end
    it 'should set the run count' do
      expect(subject.run_count).to eq 1
    end
    it 'should set the day' do
      expect(subject.day).to eq 30
    end
    it 'should set the needed pace' do
      expect(subject.needed_pace).to eq 1.01 #340/335 
    end

    context 'during a leap year' do
      before {Timecop.freeze(Time.local(2016, 1, 30))}
      after {Timecop.return}
      pending 'to implement later'
      #it 'should correctly calculate the needed pace' do
        #expect(subject.needed_pace).to eq 1.01 #340/336 one extra day
      #end
    end

  end
end
