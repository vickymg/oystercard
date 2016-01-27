require 'station'

describe Station do 

  subject(:station) {Station.new(:name, :zone)}

    describe '#initialisation' do

      describe 'what zone a station is in' do
        it 'should tell you what zone a station is in' do
          expect(station).to have_attributes(:name => :name, :zone => :zone)
        end 
      end 
    end 
  end 	