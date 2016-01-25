class Oystercard

  attr_reader :balance, :max_balance

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @max_balance = MAX_BALANCE
  end

  def top_up(amount)
    fail "Exceeded max balance of #{MAX_BALANCE}!" if max_balance?(amount)
    @balance += amount
  end



private

  def max_balance?(amount)
    @balance + amount > MAX_BALANCE
  end

end
