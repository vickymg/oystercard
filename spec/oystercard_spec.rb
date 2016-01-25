require 'oystercard'

describe Oystercard do

  subject(:oystercard) {described_class.new}

  describe "#initialize" do

    it {is_expected.to respond_to(:balance)}

    it "has an initial balance of 0" do
      expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end

  end
end
