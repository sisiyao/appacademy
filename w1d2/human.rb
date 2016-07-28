class HumanPlayer
  attr_accessor :board_hash

  def prompt
    guess = [nil, nil]
    puts "Enter x: "
    guess[0] = gets.chomp.to_i
    puts "Enter y: "
    guess[1] = gets.chomp.to_i
    guess
  end
end
