require_relative 'board'

class Game
  def initialize(player, computer)
    @board = Board.new
    @player = player
    @computer = computer
    @code = @computer.code
    @turn = 1
    @game_over = false
  end

  def play
    while @turn < 13 && @game_over == false do
      puts "Computer code: #{@code}"
      
      guess = get_guess
      feedback = check_guess(guess, @code)
      @board.update_board(@turn-2, guess, feedback)
      @board.display(@board.game_board)
    end
  end

  def get_guess
    guess = @player.guess_code
    validate_guess(guess)
    @player.code.split("")
  end

  def validate_guess(guess)
    unless guess.length == 4 
      puts 'Invalid input length, try again'
      get_guess
    else
      guess.split("").each do |char|
        unless (1..6).include?(char.to_i)
          puts 'Invalid input, try again'
          get_guess
          break
        end
      end 
    end 
  end

  def check_guess(guess, code)
    guess.map! {|char| char.to_i}
    if guess == code
      @computer.update_score(@turn)
      puts "You guessed the secret code: #{code.join("")}!"
      puts "Computer has received #{@computer.score} points!"
      @turn += 1
      @game_over = true
    elsif @turn == 12
      @computer.update_score(@turn)
      puts 'Unable to correctly guess in 12 turns :('
      puts "Computer recieves #{@computer.score} points"
      @turn += 1
    else
      @turn += 1
      @computer.give_feedback(guess, code)
    end
    @computer.give_feedback(guess, code)
  end

  
end
