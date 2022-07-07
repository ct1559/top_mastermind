class Computer
  attr_accessor :score, :code
  
  def initialize
    @score = 0
    @code = computer_code
  end

  def update_score(num)
    @score += num
  end

  def computer_code
    code = []
    for i in 0..3
      code.push(rand(1..6))
    end
    code
  end

  def give_feedback(guess, code)
    feedback = []
    guess.each_with_index do |num, index|
      if code.include?(num)
        if guess[index] == code[index]
          feedback.push('R')
        else
          feedback.push('W')
        end
      end
    end
    feedback
  end
  
end
