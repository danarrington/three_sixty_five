describe User do

  subject { create(:user, email: 'user@example.com') }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(subject.email).to match 'user@example.com'
  end

  describe '#recalculate_total_distance!' do
    before {subject.total_distance = 10}
    let!(:run) {create(:run, user: subject, runtype: :run, distance: 2.0)}
    let!(:walk) {create(:run, user: subject, runtype: :walk, distance: 2.5)}

    it 'should sum all runs' do
      subject.recalculate_total_distance!
      expect(subject.total_distance).to eq 4.5
    end
  end

end
