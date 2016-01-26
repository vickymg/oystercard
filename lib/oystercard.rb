class Oystercard

  attr_reader :balance, :max_balance, :entry_station

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
  end


  def top_up(amount)
    fail "Exceeded max balance of #{MAX_BALANCE}!" if max_balance?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Not enough money on card!" if @balance < MIN_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

private

  def max_balance?(amount)
    @balance + amount > MAX_BALANCE
  end

  def top_up_needed?(fare)
    @balance - fare < 0
  end

  def deduct(fare)
    fail "Please top up your Oystercard" if top_up_needed?(fare)
    @balance -= fare
  end

end
