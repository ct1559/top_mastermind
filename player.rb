# frozen_string_literal: true

# This class creates a new player object and has player related methods
class Player
  attr_reader :name
  attr_accessor :code, :score

  def initialize(name)
    @name = name
    @score = 0
    @code = ''
  end

  def update_score(num)
    @score += num
  end

  def guess_code
    puts 'Enter guess (four digits 1-6)'
    guess = gets
    @code = guess.chomp!
    validate_guess(@code, "guesser")
    @code.split("")
  end

  def validate_guess(guess, type)
    unless guess.length == 4 
      puts 'Invalid input length, try again'
      type == "guesser" ? guess_code : create_code
    else
      guess.split("").each do |char|
        unless (1..6).include?(char.to_i)
          puts 'Invalid input, try again'
          type == "guesser" ? guess_code : create_code
          break
        end
      end 
    end 
  end

  def create_code
    puts 'Enter your secret code (four digits 1-6)'
    user_input = gets
    user_input.chomp!
    validate_guess(user_input, "creator")
    code = user_input.split("")
    code.map! {|char| char.to_i}
    @code = code
  end

  def give_feedback(guess, code)
    puts "Give feedback guess: #{guess}"
    # Player gives computer feedback for each pos in order
    feedback = []
    # Count how many time each digit occurs in code
    digit_count = Hash.new(0)
    code.each {|digit| digit_count[digit] += 1}
    puts "Feedback = #{code}"
    guess.each_with_index do |num, index|
      if code.include?(num) 
        if guess[index] == code[index]
          if digit_count[num] == 0
            feedback[feedback.index('W')] = ' '
            feedback.push('R')
          else
            digit_count[num] -= 1
            feedback.push('R')
          end
        elsif digit_count[num] > 0 && guess[index] != code[index]
          digit_count[num] -= 1
          feedback.push('W')
        else
          feedback.push(' ')
        end
      else
        feedback.push(' ')
      end
    end
    feedback
  end
end
