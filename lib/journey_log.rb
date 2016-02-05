class JourneyLog
  attr_reader :set_log

  def initialize
    @journey_history = []
  end

  def journeys
    @journey_history.dup
  end

  def set_log(current_journey)
    @journey_history << current_journey
  end
end
