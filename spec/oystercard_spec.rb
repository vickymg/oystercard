require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:topup_amount) {5}
  let(:random_topup_amount) {rand(1..20)}
  let(:too_large_topup) {91}
  let(:set_fare) {2}

  describe "#initialize" do

    it {is_expected.to respond_to(:balance)}

    it "has an initial balance of 0" do
      expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it {is_expected.to respond_to(:max_balance)}

    it "has a max balance of 90" do
      expect(oystercard.max_balance).to eq Oystercard::MAX_BALANCE
    end

    it {is_expected.to respond_to(:in_journey?)}

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
        expect{oystercard.top_up(too_large_topup)}.to raise_error "Exceeded max balance of #{Oystercard::MAX_BALANCE}!"
      end

    end

  end

  describe "#deduct(fare)" do

    it{is_expected.to respond_to(:deduct).with(1).argument}

    before do
      oystercard.top_up(topup_amount)
    end

    it "Will deduct the fare from the oystercard balance" do
      expect(oystercard.deduct(set_fare)).to eq oystercard.balance
    end

    context "Cannot have a negative balance" do

      before do
        2.times {oystercard.deduct(set_fare)}
      end

      it "Will raise error 'Please top up your Oystercard'" do
        expect{oystercard.deduct(set_fare)}.to raise_error "Please top up your Oystercard"
      end

    end
  end

  describe "#touch in" do

    it "touches in and changes status to in_journey" do
      expect(oystercard.touch_in).to eq :in_journey
    end

    it "returns in_journey when touched in" do
      oystercard.touch_in
      expect(oystercard.status).to eq :in_journey
    end

  end

  describe "#touch out" do

    it "touches out and changes status to out_of_journey" do
      expect(oystercard.touch_out).to eq :out_of_journey
    end

    it "returns out_of_journey when touched out" do
      oystercard.touch_out
      expect(oystercard.status).to eq :out_of_journey
    end

  end

  describe "#in_journey?" do

    before do
      oystercard.touch_in
    end

    it "returns true when touched in" do
      expect(oystercard.in_journey?).to be true
    end

    it "returns false when touched out" do
      oystercard.touch_out
      expect(oystercard.in_journey?).to be false
    end

  end

end
