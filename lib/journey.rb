class Journey

  attr_reader :entry_station, :exit_station

  PENALTY_FARE = 6

  def initialize
    @complete = false
  end

  def start(entry_station = nil)
    @entry_station = entry_station
  end

  def finish(exit_station = nil)
    @exit_station = exit_station
    @complete = true
    fare
    self
  end

  def fare
    if penalty?
      @fare = PENALTY_FARE
    else
      @fare = Oystercard::MIN_FARE
    end
  end

  def complete?
    @complete
  end

  private

  def penalty?
    (!entry_station || !exit_station)
  end

end
