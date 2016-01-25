require 'oystercard'


describe Oystercard do
	let(:oystercard) { Oystercard.new }

	it 'should have a balance of 0' do
		expect(oystercard.balance).to eq(0)
	end

	describe 'top_up' do

   	it {is_expected.to respond_to(:top_up).with(1).argument}

   	it 'should top up the balance' do
   		oystercard.top_up(10)
   		expect(oystercard.balance).to eq(10)
         #above could be written using .to change .by
   	end

		it "should have a maximum limit of #{Oystercard::MAXIMUM_LIMIT}" do
			expect { oystercard.top_up(91) }.to raise_error "Cannot top up! Maximum limit #{Oystercard::MAXIMUM_LIMIT}!"
		end
	end
end
