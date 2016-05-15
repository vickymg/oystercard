require 'oystercard'

describe Oystercard do

  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) {double :journey}

    it 'should have a balance of zero' do
      expect(subject.balance).to eq(0)
    end

    it 'should have a max balance of 90' do
      expect(Oystercard::MAX_BALANCE).to eq(90)
    end

    it 'raises an error if insufficient funds' do
      message = "Insufficient funds!"
      expect{ subject.touch_in(entry_station) }.to raise_error(message)
    end

    it 'should top-up the balance' do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by(10)
    end

    it 'should raise an exception if balance exceeded' do
      max = Oystercard::MAX_BALANCE
      message = "Maximum balance of #{max} exceeded!"
      expect{ subject.top_up(max + 1) }.to raise_error(message)
    end

    context 'journeys' do

    before(:each) do
      subject.top_up(10)
    end

    describe "#touch_in" do

      it 'remembers entry station' do
        expect(subject.journey).to receive(:start).with(entry_station)
        subject.touch_in(entry_station)
      end

    end

    describe '#touch_out' do

      it 'remembers the exit station' do
        expect(subject.journey).to receive(:finish).with(exit_station)
        subject.touch_out(exit_station)
      end

      it 'deducts the minimum fare' do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        min_fare = Oystercard::MIN_FARE
        expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-min_fare)
      end

      it 'deducts a penalty fare if no entry station' do
        subject.touch_out(exit_station)
        penalty = Journey::PENALTY_FARE
        expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-penalty)
      end

    end
  end
end
