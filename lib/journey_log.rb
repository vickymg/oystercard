class JourneyLog

  def initialize
    @journey_history = []
  end

  def set_journey_history(record_journey)
    @journey_history << record_journey
  end

  def journeys
    @journey_history.dup
  end

end
