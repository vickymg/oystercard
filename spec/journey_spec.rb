require 'journey'

describe Journey do
  
  let(:entry_station) { double :station, zone: 1}
  let(:exit_station) { double :station, zone: 2}

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when exiting a journey" do
    expect(subject.finish(exit_station)).to eq(subject)
  end

  context 'given an entry station' do
    subject {described_class.new}

    it "returns a penalty fare if no exit station given" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'has an entry station' do
      subject.start(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

    context 'given an exit station' do

      before do
        subject.start(entry_station)
        subject.finish(exit_station)
      end

      it 'calculates a fare' do
        expect(subject.fare).to eq 1
      end

      it "knows if a journey is complete" do
        expect(subject).to be_complete
      end

    end
  end
end
