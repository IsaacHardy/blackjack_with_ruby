class Player

  attr_reader :money

  def initialize
    @money = 100
  end

  def win_hand
    @money += 10
  end

  def lose_hand
    @money -= 10
  end
end
