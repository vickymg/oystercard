require 'oystercard'

describe Oystercard do

	subject(:oystercard) { Oystercard.new }
	let(:station) { double :station }
	let(:exit_station) { double :station }

	it 'should have a balance of 0' do
		expect(oystercard.balance).to eq(0)
	end

	describe '#top_up' do

	   it 'should top up the balance' do
	 		 expect{oystercard.top_up(10)}.to change {oystercard.balance}.by(10)
	   end

		it 'should raise an error if maximum balance exceeded' do
			maximum_balance = Oystercard::MAXIMUM_BALANCE
			oystercard.top_up(maximum_balance)
			expect { oystercard.top_up(1) }.to raise_error "Cannot top up! Maximum limit #{maximum_balance}!"
		end
	end

		describe '#touch in' do

			it 'should raise an error if insufficient funds' do
				expect {oystercard.touch_in(station)}.to raise_error "Insufficient funds"
			end

		end

		describe '#touch out' do

			xit 'holds the journey history' do
			  expect(oystercard.journey_history).to include record_journey
			end

		end

end
