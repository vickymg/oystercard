class Journey

attr_reader :entry_station, :exit_station, :fare

  def initialize(station = nil)
    @entry_station = station
  end

  def end_journey(exit_station = nil)
    @exit_station = exit_station
  end

  def fare
    if @entry_station == nil || @exit_station == nil
      @fare = 6
    else
      @fare = Oystercard::MINIMUM_FARE
    end
  end

  def complete?
    true
  end

end
