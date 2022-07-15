# frozen_string_literal: true

require_relative 'display'
# This class creates the game board that will be printed to the console
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
