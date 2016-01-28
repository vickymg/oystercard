require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey_history, :record_journey, :in_journey

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(journey = Journey.new)
    @balance = 0
    @in_journey = false
    @journey = journey
    @record_journey = {}
    @journey_history = []
  end

  def top_up(amount)
    raise "Cannot top up! Maximum limit #{MAXIMUM_BALANCE}!" if @balance + amount > MAXIMUM_BALANCE
  	@balance += amount
  end

  def touch_in(station)
  	raise "Insufficient funds" if @balance < MINIMUM_FARE
    if in_journey?
      @record_journey[:exit_station] = nil
      set_journey_history
    else
      @in_journey = true
      @journey.start_station(station)
      @record_journey[:entry_station] = station
    end
  end

  def touch_out(exit_station)
    unless in_journey?
      @record_journey[:entry_station] = nil
      set_journey_history
    else
      deduct(MINIMUM_FARE)
      @journey.end_journey(exit_station)
      @in_journey = false
      @record_journey[:exit_station] = exit_station
      set_journey_history
    end
  end

  private

  def in_journey?
    !!@in_journey
  end

  def deduct(amount)
  	@balance -= amount
  end

  def set_journey_history
    @journey_history << record_journey.dup
    @record_journey = {}
  end

end
