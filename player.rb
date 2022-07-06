class Player
  attr_accessor :code
  
  def initialize(name)
    @name = name
    @score = 0
    @code = ""
  end

  def update_score(num)
    @score += num
  end

  def guess_code
    puts 'Enter guess (four digits 1-6)'
    guess = gets
    @code = guess.chomp!
  end

end
