require_relative 'oystercard'

class Journey

  attr_reader :journey_start, :journey_end

  def initialize(station)
    @journey_start = station
    @journey_end = nil
  end

  def end_journey(station)
    @journey_end = station
  end

  def journey_complete?
    true if !!@journey_start && !!@journey_end
  end

end
