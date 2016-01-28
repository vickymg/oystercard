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

  def set_journey_history
    current_journey = {}
    current_journey[:entry_station] = @entry_station
    current_journey[:exit_station] = @exit_station
    @log.set_log(current_journey)
  end

  def fare
    if complete?
      @fare = Oystercard::MINIMUM_FARE
    else
      @fare = PENALTY_FARE
    end
  end

  def complete?
    false if @log.journeys.last.values.include?(nil)
  end

  def reset
    start_station(nil)
    end_journey(nil)
  end



end
