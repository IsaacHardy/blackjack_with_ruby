require_relative "deck"
require_relative "player"

class Game

  def initialize
    @player = Player.new
  end


  def run_game
    while @player.money > 0 do
      puts "You have $#{@player.money} and bet $10."

      start_hand

      while get_hit_or_stand do
        @hand.push(@deck.draw)

        @hand.each do |card|
          puts card.rank
        end
      end

      @player.lose_hand
    end
    puts "You have no more money left to play."
  end

  def start_hand
    @deck = Deck.new
    @deck.shuffle
    @hand = []

    2.times do
      @hand.push(@deck.draw)
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
