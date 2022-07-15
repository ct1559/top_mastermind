# frozen_string_literal: true

require_relative 'board'
# This class handles the gameplay
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
    puts
    choice.chomp!
    if !(1..2).include?(choice.to_i)
      puts 'Invalid choice. Try again.'
      choose_mode
    elsif choice == '1'
      puts "#{@player.name} will be the guesser and the Computer will be creator!\n\n"
      guesser = @player
      creator = @computer
      play(guesser, creator)
    else
      puts "Computer will be the guesser and #{@player.name} will be creator!\n\n"
      guesser = @computer
      creator = @player
      play(guesser, creator)
    end
    play_again
  end

  def play(guesser, creator)
    @code = creator.create_code

    while @turn < 13 && @game_over == false do
      puts
      if guesser == @player
        guess = guesser.guess_code
      else
        guess = guesser.guess_code(@turn, @feedback)
      end

      @feedback = check_guess(guess, @code, guesser, creator)
      @board.update_board(@turn-2, guess, @feedback)
      puts
      puts "TURN #{@turn - 1}"
      @board.display(@board.game_board)
    end
  end

  def check_guess(guess, code, guesser, creator)
    guess.map! {|char| char.to_i}
    if guess == code
      creator.update_score(@turn)
      puts "#{guesser.name} guessed the secret code: #{code.join("")}!"
      puts "#{creator.name} has received #{@turn} points!"
      @game_over = true
      @turn += 1
      creator.give_feedback(guess, code)
    elsif @turn == 12
      creator.update_score(@turn)
      puts 'Unable to correctly guess in 12 turns :('
      puts "The secret code was: #{code}"
      puts "#{creator.name} recieves 12 points"
      @game_over = true
      @turn += 1
      creator.give_feedback(guess, code)
    else
      @turn += 1
      creator.give_feedback(guess, code)
    end
  end

  def play_again
    puts
    puts 'Play again? Enter "y" for yes or "n" for no'
    user_input = gets
    user_input.chomp!
    if user_input == 'y' || user_input == 'Y'
      @turn = 1
      @game_over = false
      @board = Board.new
      choose_mode
    elsif user_input == 'n' || user_input == 'N'
      puts 'FINAL SCORES'
      puts "Player: #{@player.score}   Computer: #{@computer.score}"
    else
      'Invalid input, try again'
      play_again
    end
  end
end
