class TowersOfHanoi
  attr_reader :piles

  def initialize
    @piles = [[3,2,1],[],[]]
  end

  def play
    until won?
      display
      round
    end
    puts "You won!"
  end

  def round
    input = [10,10]
    until valid_input?(input)
      input = get_input
    end
    move(input)
  end

  def display
    @piles.each_with_index do |row, i|
      puts "pile:#{i} | #{row.join("")}"
    end
  end

  def move(pos)
    start, fin = pos
    @piles[fin] << @piles[start].pop
  end

  def get_input
    puts "Choose start and end piles! (start, end)"
    input = gets.chomp
    [input[0].to_i, input[-1].to_i]
  end

  def valid_input?(input)
    # debugger
    start, fin = input
    return false unless start.between?(0,2) && fin.between?(0,2)
    return false if start == fin
    return true if @piles[fin].empty?
    return false unless @piles[start].last < @piles[fin].last
    true
  end

  def won?
    return true if @piles == [[],[],[3,2,1]]
    return true if @piles == [[],[3,2,1],[]]
    false
  end
end

# TowersOfHanoi.new.play
