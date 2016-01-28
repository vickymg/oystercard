class JourneyLog

  attr_reader :journey_history

  def initialize
    @journey_history = []
  end

  def set_journey_history(record_journey)
    @journey_history << record_journey
  end

end
