require 'journey'

describe Journey do

let(:station) {double :station, zone: 1}
let(:exit_station) {double :station, zone: 2}
subject(:journey) {Journey.new(station)}

  it 'should have a entry station' do
    expect(journey.entry_station).to eq station
  end


  it 'should have an exit station' do
    expect(journey.end_journey(exit_station)).to eq exit_station
  end

  describe 'journey charging' do

    it 'should return a minimum fare' do
      journey.end_journey(exit_station)
      expect(journey.fare).to eq Oystercard::MINIMUM_FARE
    end

    it 'should return a penalty fare' do
      incomplete_journey = Journey.new
      expect(incomplete_journey.fare).to eq 6
    end

  end

end
