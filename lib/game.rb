require_relative "deck"
require_relative "player"

class Game
  TOTAL = 0
  def initialize
    @player = Player.new
    @deck
    @hand
    @total
    @dealer_total
    @dealer_hand
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
            cards.push(card.rank)
          end
        end

        puts "You hit. You have a #{cards.join(", ")} and a #{@hand[@hand.length - 1].rank} in your hand. Your total is #{@total}."
        break if @total > 21
      end

      determine_winner
    end
    puts "You have no more money left to play."
  end

  def determine_winner
    new_hand("dealer")

    if @total > 21
      puts "You bust."
      return @player.lose_hand
    end

    while @dealer_total <= 21
      break if @dealer_total > @total || @dealer_total == 21
      puts "The dealer hits."

      @dealer_hand.push(@deck.draw)
      dealer_hand_total
    end


    if @dealer_total > @total && @dealer_total <= 21
      puts "The dealer stands. The dealer total has a total of #{@dealer_total}. You lose!"
      @player.lose_hand
    elsif @dealer_total > 21 && @total <= 21
      puts "The dealer total has a total of #{@dealer_total}. The dealer busts. You win!"
      @player.win_hand
    else
      puts "The dealer stands. The dealer total has a total of #{@dealer_total}. You win!"
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
      puts "You have a #{@hand[0].rank} and a #{@hand[1].rank} in your hand. Your total is #{@total}."
    elsif who == "dealer"
      @dealer_hand = []

      2.times do
        @dealer_hand.push(@deck.draw)
      end

      dealer_hand_total
    end
  end

  def hand_total
    aces = @hand.select do |card|
      card.rank == :A
    end

    non_aces = @hand.select do |card|
      card.rank != :A
    end

    aces_values = aces.map do |card|
      card.value
    end

    non_aces_values = non_aces.map do |card|
      card.value
    end

    @total = non_aces_values.reduce do |total, value|
      total += value
    end

    if aces_values.length > 0
      aces_values.each do |value|
        if @total < 11
          @total += value
        else
          @total += 1
        end
      end
    end
  end

  def dealer_hand_total
    aces = @dealer_hand.select do |card|
      card.rank == :A
    end

    non_aces = @dealer_hand.select do |card|
      card.rank != :A
    end

    aces_values = aces.map do |card|
      card.value
    end

    non_aces_values = non_aces.map do |card|
      card.value
    end

    @dealer_total = non_aces_values.reduce do |total, value|
      total += value
    end

    if aces_values.length > 0
      aces_values.each do |value|
        if @dealer_total < 11
          @dealer_total += value
        else
          @dealer_total += 1
        end
      end
    end
  end

  def get_hit_or_stand
    while true
      print "Do you want to (h)it or (s)tand? "
      answer = gets.chomp.downcase
      puts
      if answer[0] == "h"
        return true
      elsif answer[0] == "s"
        return false
      end
      puts "That is not a valid answer!"
    end
  end
end
