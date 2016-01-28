require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :in_journey, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(journey = Journey.new)
    @balance = 0
    @in_journey = false
    @journey = journey
  end

  def top_up(amount)
    raise "Cannot top up! Maximum limit #{MAXIMUM_BALANCE}!" if @balance + amount > MAXIMUM_BALANCE
  	@balance += amount
  end

  def touch_in(station)
  	raise "Insufficient funds" if @balance < MINIMUM_FARE
    if in_journey?
      @journey.end_journey(nil)
      set_log
      @journey.start_station(station)
    else
      @in_journey = true
      @journey.start_station(station)
    end
  end

  def touch_out(exit_station)
    unless in_journey?
      @journey.start_station(nil)
      @journey.end_journey(exit_station)
      set_log
    else
      deduct(MINIMUM_FARE)
      @journey.end_journey(exit_station)
      @in_journey = false
      set_log
    end
  end

  private

  def in_journey?
    !!@in_journey
  end

  def deduct(amount)
  	@balance -= amount
  end

  def set_log
    @journey.set_journey_history
  end




end
