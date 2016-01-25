class Oystercard

  attr_reader :balance, :max_balance, :status

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @max_balance = MAX_BALANCE
    @status = :out_of_journey
  end


  def top_up(amount)
    fail "Exceeded max balance of #{MAX_BALANCE}!" if max_balance?(amount)
    @balance += amount
  end

  def deduct(fare)
    fail "Please top up your Oystercard" if top_up_needed?(fare)
    @balance -= fare
  end

  def touch_in
    @status = :in_journey
  end

  def touch_out
    @status = :out_of_journey
  end

  def in_journey?
    @status == :in_journey ? true : false
  end

private

  def max_balance?(amount)
    @balance + amount > MAX_BALANCE
  end

  def top_up_needed?(fare)
    @balance - fare < 0
  end

end
