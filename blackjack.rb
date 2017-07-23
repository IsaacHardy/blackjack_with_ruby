require_relative './lib/game'

puts "Hello and welcome to the game of blackjack! Let's begin."
puts
puts

game = Game.new
game.run_game
