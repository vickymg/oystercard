require 'journey'

describe "feature_test" do

  it 'has a journey start point' do
    journey = Journey.new(station)
    expect(journey.journey_start).to eq(station)
  end

end
