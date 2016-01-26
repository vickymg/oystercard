require_relative 'station'

STATION_LIST = [["Euston", "zone 1"], ["Angel", "zone 2"], ["Aldgate East", "zone 2"],
["Cockfosters", "zone 4"], ["Piccadilly Circus", "zone 1"]]

class Oystercard

  attr_reader :balance, :max_balance, :entry_station, :journey_list
  attr_reader :station_list

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
    @journey_list = {}
    @stations = structify(STATION_LIST)
  end

  def top_up(amount)
    fail "Exceeded max balance of #{MAX_BALANCE}!" if max_balance?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Not enough money on card!" if @balance < MIN_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    add_journey(@entry_station, station)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def select_random_station
    @stations[rand(0...@stations.length)]
  end


private

  def max_balance?(amount)
    @balance + amount > MAX_BALANCE
  end

  def top_up_needed?(fare)
    @balance - fare < 0
  end

  def deduct(fare)
    fail "Please top up your Oystercard" if top_up_needed?(fare)
    @balance -= fare
  end

  def add_journey(station, exit_station)
    @journey_list[station] = exit_station
  end

  Station = Struct.new(:name, :zone)

  def structify(stations)
    stations.collect{ |pair| Station.new(pair[0], pair[1])}
  end

end
