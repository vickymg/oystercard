
class Oystercard

  attr_reader :balance, :journey_history, :record_journey, :entry_station, :exit_station

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  # DEFAULT_OYSTER_HISTORY = Array.new

  def initialize
    @balance = 0
    @record_journey = {}
    @journey_history = []
  end

  def top_up(amount)
    raise "Cannot top up! Maximum limit #{MAXIMUM_BALANCE}!" if @balance + amount > MAXIMUM_BALANCE
  	@balance += amount
  end

  def touch_in(entry_station)
  	raise "Insufficient funds" if @balance < MINIMUM_FARE
    @entry_station = entry_station
  	@record_journey[:entry] = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
    @entry_station = nil
    @record_journey[:exit] = exit_station
  end

  def in_journey?
  	!!entry_station
  end

  private

  def deduct(amount)
  	@balance -= amount
  end
end
