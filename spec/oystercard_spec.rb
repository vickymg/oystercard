require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:topup_amount) {5}
  let(:random_topup_amount) {rand(1..20)}
  let(:set_fare) {2}

  describe "#initialize" do

    it {is_expected.to respond_to(:balance)}

    it "has an initial balance of 0" do
      expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it "is not in use" do
      expect(oystercard).not_to be_in_journey
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
      expect(oystercard.touch_in).to eq true
    end

    it "raises an error if balance is below minimum" do
      expect{oystercard.touch_in}.to raise_error "Not enough money on card!"
    end
  end

  describe "#touch_out" do

    it "touches out and changes status to not in use" do
      oystercard.instance_variable_set("@balance", 1)
      expect(oystercard.touch_out).to eq false
    end

    it 'deducts the fare from the balance' do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.instance_variable_set("@in_use", true)
      expect{oystercard.touch_out}.to change{oystercard.balance}.by(-(Oystercard::MIN_FARE))
    end

  end

  describe "#in_journey?" do

    before do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.touch_in
    end

    it "returns true when touched in" do
      expect(oystercard).to be_in_journey
    end

    it "returns false when touched out" do
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

   end

end
