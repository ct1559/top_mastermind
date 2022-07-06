require_relative 'game'
require_relative 'computer'
require_relative 'player'
require_relative 'board'

def play_game
  
  puts "Enter player name:"
  name = gets
  player = Player.new(name.chomp)
  computer = Computer.new
  game = Game.new(player, computer)
  game.play
  
end

play_game
