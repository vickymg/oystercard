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

			it 'should complete previous journey with nil when touch_in twice' do
				oystercard.top_up(20)
				oystercard.touch_in(station)
				oystercard.touch_in(station)
				expect(oystercard.journey.log.journeys.last.values).to include(nil)
			end

			context 'fares' do

				it 'deducts the penalty fare on touch out when journey incomplete' do
					oystercard.top_up(20)
					oystercard.touch_in(station)
					expect{oystercard.touch_in(station)}.to change(oystercard, :balance).by(-6)
				end

			end

		end

		describe '#touch out' do

				it 'should complete journey with nil when touch_out without touch_in' do
					oystercard.top_up(20)
					oystercard.touch_out(exit_station)
					expect(oystercard.journey.log.journeys.last.values).to include(nil)
				end

			context 'fares' do

				before do
					oystercard.top_up(20)
				end

				it 'deducts the minimum fare on touch out' do
					oystercard.touch_in(station)
					expect{oystercard.touch_out(exit_station)}.to change(oystercard, :balance).by(-1)
				end

				it 'deducts the penalty fare on touch out when journey incomplete' do
					expect{oystercard.touch_out(station)}.to change(oystercard, :balance).by(-6)
				end

			end

		end

end
