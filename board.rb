require_relative 'display'

class Board
  attr_accessor :game_board

  include Display
  
  def initialize
    @game_board = [['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-']]
  end
  # guess is an array
  def update_board(turn, guess, feedback)
    @game_board[turn] = guess + ['   '] + feedback.shuffle
  end
end