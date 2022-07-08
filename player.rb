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
    validate_guess(@code)
    @code.split("")
  end

  def validate_guess(guess)
    unless guess.length == 4 
      puts 'Invalid input length, try again'
      guess_code
    else
      guess.split("").each do |char|
        unless (1..6).include?(char.to_i)
          puts 'Invalid input, try again'
          guess_code
          break
        end
      end 
    end 
  end

  def create_code
    puts 'Enter your secret code (four digits 1-6)'
    user_input = gets
    user_input.chomp!
    code = user_input.split("")
    code.map! {|char| char.to_i}
    @code = code
  end

  def give_feedback(guess, code)
    feedback = []
    # Count how many time each digit occurs in code
    digit_count = Hash.new(0)
    code.each {|digit| digit_count[digit] += 1}
    guess.each_with_index do |num, index|
      if code.include?(num)
        if guess[index] == code[index]
          if digit_count[num] == 0
            feedback.delete_at(feedback.index('W'))
            feedback.push('R')
          else
            digit_count[num] -= 1
            feedback.push('R')
          end
        elsif digit_count[num] > 0 && guess[index] != code[index]
          digit_count[num] -= 1
          feedback.push('W')
        end
      end
    end
    feedback
  end

end
