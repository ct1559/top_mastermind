class Computer
  attr_accessor :score, :code
  attr_reader :name
  
  def initialize
    @name = "Computer"
    @score = 0
    @code = create_code
    @set = guess_set
  end

  def update_score(num)
    @score += num
  end

  def create_code
    code = []
    for i in 0..3
      code.push(rand(1..6))
    end
    code
  end

  def guess_code(turn, feedback)
    if turn == 1
      "1122".split("")
    else
      puts 'in progress'
      puts feedback
      "2211".split("")
    end
  end

  def guess_set
    set = []
    for i in 1..6
      for j in 1..6
        for k in 1..6
          for l in 1..6
            set.push(i.to_s + j.to_s + k.to_s + l.to_s)
          end
        end
      end
    end
    set
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
