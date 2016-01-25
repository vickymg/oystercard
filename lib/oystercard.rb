
class Oystercard

  attr_reader :balance

  MAXIMUM_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Cannot top up! Maximum limit #{MAXIMUM_LIMIT}!" if @balance + amount > MAXIMUM_LIMIT
  	@balance += amount
  end

end
