require_relative "deck"
require_relative "player"

class Game

  def initialize
    @player = Player.new
  end

  def run_game
    while @player.money > 0 do
      puts "You have $#{@player.money} and bet $10."

      @deck = Deck.new
      @deck.shuffle

      new_hand("player")

      while get_hit_or_stand do
        @hand.push(@deck.draw)
        hand_total

        cards = []
        @hand.each_with_index do |card, index|
          if index != @hand.length - 1
            cards.push(card.value)
          end
        end

        puts "You have a #{cards.join(", ")} and a #{@hand[@hand.length - 1].value} in your hand. Your total is #{@total}."
      end

      determine_winner
    end
    puts "You have no more money left to play."
  end

  def determine_winner
    new_hand("dealer")
    while @dealer_total < @total
      @dealer_hand.push(@deck.draw)
      dealer_hand_total

      puts "Dealer total is #{@dealer_total}."
    end

    if @dealer_total > @total && @dealer_total <= 21
      @player.lose_hand
    else
      @player.win_hand
    end
  end

  def new_hand(who)

    if who == "player"
      @hand = []

      2.times do
        @hand.push(@deck.draw)
      end

      hand_total
      puts "You have a #{@hand[0].value} and a #{@hand[1].value} in your hand. Your total is #{@total}."
    elsif who == "dealer"
      @dealer_hand = []

      2.times do
        @dealer_hand.push(@deck.draw)
      end

      dealer_hand_total
    end
  end

  def hand_total
    values = @hand.map do |card|
      card.value
    end

    @total = values.reduce do |total, value|
      total += value
    end
  end

  def dealer_hand_total
    values = @dealer_hand.map do |card|
      card.value
    end

    @dealer_total = values.reduce do |total, value|
      total += value
    end
  end

  def get_hit_or_stand
    while true
      print "Do you want to (h)it or (s)tand? "
      answer = gets.chomp.downcase
      if answer[0] == "h"
        return true
      elsif answer[0] == "s"
        return false
      end
      puts "That is not a valid answer!"
    end
  end
end
