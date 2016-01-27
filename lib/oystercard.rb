require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey_history, :record_journey

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey = nil
    @record_journey = {}
    @journey_history = []
  end

  def top_up(amount)
    raise "Cannot top up! Maximum limit #{MAXIMUM_BALANCE}!" if @balance + amount > MAXIMUM_BALANCE
  	@balance += amount
  end

  def touch_in(station)
  	raise "Insufficient funds" if @balance < MINIMUM_FARE
    # @journey = Journey.new(station)
    # @record_journey[:station] = station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @journey.end_journey(exit_station)
    # @record_journey[:station] = exit_station
    # journey_history << record_journey
    # record_journey = {}
  end

  private

  def deduct(amount)
  	@balance -= amount
  end
end
