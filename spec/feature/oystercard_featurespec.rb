require 'oystercard'

describe 'feature_test' do
  it 'Tops up oystercard' do
    card = Oystercard.new
    amount = 100
    card.top_up(amount)
    expect(card.balance).to eq amount
  end
end
