require_relative 'journey_log'

class Journey

attr_reader :entry_station, :exit_station, :fare, :log

PENALTY_FARE = 6

  def initialize(journey_klass = JourneyLog.new)
    @log = journey_klass
  end

  def start_station(station)
    @entry_station = station
  end

  def end_journey(exit_station = nil)
    @exit_station = exit_station
  end

  def fare
    if @entry_station == nil || @exit_station == nil
      @fare = PENALTY_FARE
    else
      @fare = Oystercard::MINIMUM_FARE
    end
  end

  def complete?
    true
  end

end
