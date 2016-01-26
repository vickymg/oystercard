require 'oystercard'

describe 'feature_test' do
  it 'Tops up oystercard' do
    card = Oystercard.new
    amount = 20
    card.top_up(amount)
    expect(card.balance).to eq amount
  end

  it 'Stops you putting too much money on your card' do
    card = Oystercard.new
    amount = 91
    expect{card.top_up(amount)}.to raise_error("Exceeded max balance of #{Oystercard::MAX_BALANCE}!")
  end

  it 'deducts money from oystercard' do
    card = Oystercard.new
    amount = 20
    fare = 2
    card.top_up(amount)
    expect(card.deduct(fare)).to eq 18
  end

  it 'stops user touching in if balance is less than minimum fare' do
    card = Oystercard.new
    expect{card.touch_in}.to raise_error "Not enough money on card!"
  end

end
