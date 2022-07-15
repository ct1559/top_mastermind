# frozen_string_literal: true

require 'set'
# This class creats a Computer object and contains computer related methods
class Computer
  attr_accessor :score, :code
  attr_reader :name, :set

  def initialize
    nums = '123456'.chars
    @name = 'Computer'
    @score = 0
    @code = create_code
    @set = nums.product(*[nums] * 3).map(&:join)
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
    # convert code nums to strings to compare with set codes
    code_s = @code.map {|num| num.to_s}
    # Store indicies that shouldn't change, letters that need new position, and 
    # indicies that need a new num
    no_change = []
    new_pos = Hash.new([])
    new_num = []

    if turn == 1
      @code = "1111".chars
    else
      feedback.each_with_index do |fb, index|
        if fb == 'R'
          no_change.push(index)
        elsif fb == 'W'
          if new_pos[@code[index]] == nil
            new_pos[@code[index]] = Array.new
          end
          new_pos[@code[index]].push(index)
          new_num.push(index)
        else
          new_num.push(index)
        end
      end

      @code.each_with_index do |num, index|
        if new_num.include?(index)
          if new_pos.has_key?(num) == false
            puts "Made it here, index: #{index}. code[index]: #{@code[index]}"
            puts "num = #{num.to_i}"
            @code[index] += 1
            @code[index] = @code[index].to_s
          else
            puts "In else, first new_pos = #{new_pos.first}"
            @code[index] = new_pos.first
            new_pos[num].delete_at(index)
            new_pos.compact
          end
          @code
        end
      end
    end
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
        elsif digit_count[num] > 0 
          digit_count[num] -= 1
          feedback.push('W')
        end
      end
    end
    feedback
  end
end
