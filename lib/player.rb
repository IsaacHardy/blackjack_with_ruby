class Player

  attr_reader :money

  def initialize
    @money = 100
  end

  def win_hand
    @money += 10
    puts "You win."
  end

  def lose_hand
    @money -= 10
    puts "You lose."
  end
end
