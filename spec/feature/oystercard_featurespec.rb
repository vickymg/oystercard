require 'oystercard'

describe 'feature_test' do

  station = "station"

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


  it 'stops user touching in if balance is less than minimum fare' do
    card = Oystercard.new
    expect{card.touch_in(station)}.to raise_error "Not enough money on card!"
  end

  it 'deducts the fare for the journey on touch-out' do
    oyster = Oystercard.new
    oyster.top_up(20)
    oyster.touch_in(station)
    expect {oyster.touch_out}.to change{oyster.balance}.by(-(Oystercard::MIN_FARE))
  end

  it 'remembers the entry station' do
    oyster = Oystercard.new(20)
    oyster.touch_in(station)
    expect(oyster.entry_station).to eq station
  end

  it 'forgets the entry station on touch out' do
    oyster = Oystercard.new(20)
    oyster.touch_in(station)
    oyster.touch_out
    expect(oyster.entry_station).to eq nil
  end
end
