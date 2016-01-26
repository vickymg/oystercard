require 'oystercard'

describe Oystercard do

	let(:oystercard) { Oystercard.new }

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


	describe 'journey' do

		let(:station) {double :station}

		describe '#touch in' do

			it 'should change the status of journey to true' do
				oystercard.top_up(10)
        oystercard.touch_in(station)
				expect(oystercard.in_journey?).to eq true 
			end

			it 'should raise an error if insufficient funds' do
				expect {oystercard.touch_in(station)}.to raise_error "Insufficient funds"
			end

			it 'should remember the name of the entry station' do
				oystercard.top_up(10)
				oystercard.touch_in(station)
				expect(oystercard.entry_station).to eq station
			end 

		end

		describe '#touch out' do

			it 'should change the status of journey to false' do
				oystercard.top_up(10)
				oystercard.touch_in(station)
				expect {oystercard.touch_out}.to change {oystercard.in_journey?}.from(true).to(false)
			end

			it 'should deduct fare at end of journey (touch_out)' do
				expect {oystercard.touch_out}.to change {oystercard.balance}.by(-Oystercard::MINIMUM_FARE)
			end

			it 'should should nillify the entry station' do
				oystercard.top_up(10)
				oystercard.touch_in(station)
				expect {oystercard.touch_out}.to change {oystercard.entry_station}.to eq nil
			end 
		end
	end
end
