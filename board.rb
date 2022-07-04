require_relative 'display'

class Board
  attr_accessor :game_board

  include Display

  def initialize
    @game_board = [['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-'] , ['-', '-', '-', '-'], ['-', '-', '-', '-'], ['-', '-', '-', '-']]
  end
  # guess is an array
  def update_board(turn, guess)
    @game_board[turn] = guess
  end
end
