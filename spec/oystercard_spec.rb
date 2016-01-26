require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:topup_amount) {5}
  let(:random_topup_amount) {rand(1..20)}
  let(:set_fare) {2}
  let(:station) {double :station}
  let(:exit_station) {double :exit_station}

  describe "#initialize" do

    it {is_expected.to respond_to(:balance)}

    it "has an initial balance of 0" do
      expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it "is not in use" do
      expect(oystercard).not_to be_in_journey
    end

    it 'has en empty journey list by default' do
      expect(oystercard.journey_list).to be_empty
    end

  end

  describe "#top_up" do

    it {is_expected.to respond_to(:top_up).with(1).argument}

    it "Adds set top-up amount to balance" do
      expect(oystercard.top_up(topup_amount)).to eq (oystercard.balance)
    end

    it "Adds random top-up amount to balance" do
      expect(oystercard.top_up(random_topup_amount)).to eq (oystercard.balance)
    end

    context "top up with max balance" do

      it "raises error if max balance is exceeded" do
        oystercard.instance_variable_set("@balance", 1)
        expect{oystercard.top_up(Oystercard::MAX_BALANCE)}.to raise_error "Exceeded max balance of #{Oystercard::MAX_BALANCE}!"
      end

    end

  end

  # describe "#deduct(fare)" do
  #
  #
  #   before do
  #     oystercard.top_up(topup_amount)
  #   end
  #
  #
  #   context "Cannot have a negative balance" do
  #
  #     before do
  #       2.times {oystercard.deduct(set_fare)}
  #     end
  #
  #     it "Will raise error 'Please top up your Oystercard'" do
  #       expect{oystercard.deduct(set_fare)}.to raise_error "Please top up your Oystercard"
  #     end
  #
  #   end
  # end

  describe "#touch_in" do

    it {is_expected.to respond_to(:in_journey?)}

    it "touches in and changes status to in use" do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.touch_in(station)
      expect(oystercard).to be_in_journey
    end

    it "raises an error if balance is below minimum" do
      expect{oystercard.touch_in(station)}.to raise_error "Not enough money on card!"
    end

    it 'remembers the entry station' do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end

  end

  describe "#touch_out" do

    it "touches out and changes status to not in use" do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end

    it 'deducts the fare from the balance' do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.instance_variable_set("@in_use", true)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-(Oystercard::MIN_FARE))
    end

    it "forgets the entry station on touch-out" do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.instance_variable_set("@entry_station", station)
      oystercard.touch_out(exit_station)
      expect(oystercard.entry_station).to eq nil
    end

  end

  describe "#in_journey?" do

    before do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.touch_in(station)
    end

    it "returns true when touched in" do
      expect(oystercard).to be_in_journey
    end

    it "returns false when touched out" do
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end

   end

  describe 'journey history' do

    it 'remembers a list of journeys' do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.touch_in(station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journey_list).to include(station => exit_station)
    end

  end

end
