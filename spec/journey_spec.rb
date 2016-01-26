require 'journey'

describe Journey do
  let(:station) {double(:station)}
  subject(:journey){described_class.new(station)}

    describe '#initialize' do

      it 'is expected to start a journey' do
        expect(journey).to have_attributes(:journey_start => station)
      end


    end

  it {is_expected.to respond_to(:journey_start)}
  it {is_expected.to respond_to(:journey_end)}

end
