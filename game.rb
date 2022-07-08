require_relative 'board'

class Game
  def initialize(player, computer)
    @board = Board.new
    @player = player
    @computer = computer
    @code = ''
    @turn = 1
    @feedback = ['']
    @game_over = false
  end

  def choose_mode
    puts 'Enter "1" to be code breaker. Enter "2" to be code creator'
    choice = gets
    choice.chomp!
    p choice
    if !(1..2).include?(choice.to_i)
      puts 'Invalid choice. Try again.'
      choose_mode
    elsif choice == "1"
      puts "#{@player.name} will be the guesser and the Computer will be creator!"
      guesser = @player
      creator = @computer
      play(guesser, creator)
    else
      puts "Computer will be the guesser and #{@player.name} will be creator!"
      guesser = @computer
      creator = @player
      play(guesser, creator)
    end
  end

  def play(guesser, creator)
    @code = creator.create_code
    p @code
    
    while @turn < 13 && @game_over == false do
      if guesser == @player
        guess = guesser.guess_code
      else
        guess = guesser.guess_code(@turn, @feedback)
      end
      
      @feedback = check_guess(guess, @code, guesser, creator)
      @board.update_board(@turn-2, guess, @feedback)
      @board.display(@board.game_board)
    end
  end
  

  def check_guess(guess, code, guesser, creator)
    guess.map! {|char| char.to_i}
    if guess == code
      creator.update_score(@turn)
      puts "#{guesser.name} guessed the secret code: #{code.join("")}!"
      puts "#{creator.name} has received #{creator.score} points!"
      @game_over = true
      @turn += 1
      creator.give_feedback(guess, code)
    elsif @turn == 12
      creator.update_score(@turn)
      puts 'Unable to correctly guess in 12 turns :('
      puts "#{creator.name} recieves #{creator.score} points"
      @turn += 1
      creator.give_feedback(guess, code)
    else
      @turn += 1
      creator.give_feedback(guess, code)
    end
    #creator.give_feedback(guess, code)
  end

  
end
