module Display
  def display(board)
    puts
    board.each do |row|
      row.each {|col| print " #{col} "}
      puts
    end
  end
end
