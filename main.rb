require_relative 'game'
require_relative 'board'

def play_game
  game = Game.new
  game.play
end

play_game
