require_relative 'board'

class Game
  def initialize
    @board = Board.new()
    @player_score = 0
    @comp_score = 0
  end

  def play
    @board.display(@board.game_board)
    puts computer_code
  end

  def computer_code
    code = []
    for i in 0..3
      code.push(rand(1..6))
    end
    code
  end

end
