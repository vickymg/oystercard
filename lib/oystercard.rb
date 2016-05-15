require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :journey

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(journey: Journey.new)
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
    raise "Maximum balance of #{MAX_BALANCE} exceeded!" if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Insufficient funds!" if balance < MIN_FARE
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    @journey.finish(exit_station)
    deduct(journey.fare)
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
