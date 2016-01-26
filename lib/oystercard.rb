
class Oystercard

  attr_reader :balance, :journey
  attr_accessor :deduct

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey = false
  end

  def top_up(amount)
    raise "Cannot top up! Maximum limit #{MAXIMUM_BALANCE}!" if @balance + amount > MAXIMUM_BALANCE
  	@balance += amount
  end

  def deduct(amount)
  	@balance -= amount
  end

  def touch_in
  	raise "Insufficient funds" if @balance < MINIMUM_FARE
  	@journey = true
  end

  def touch_out
  	@journey = false
    @balance -= MINIMUM_FARE
  end
end
