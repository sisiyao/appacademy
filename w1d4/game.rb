require_relative 'board'
require 'byebug'
require 'yaml'
require 'colorize'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def run
    until won?
      @board.render
      take_turn
    end
    puts "You won!"
  end

  def take_turn
    puts "Enter coordinates or save: "
    pos = parse_pos(gets.chomp)
    save if pos == [0]
    puts "Do you want to reveal, flag or unflag?"
    val = gets.chomp
    check_tile(pos, val)
  end

  def parse_pos(pos)
    pos.split(",").map(&:to_i)
  end

  def check_tile(pos, val)
    if val == "flag"
      @board[pos].flagged = true
    elsif val == "unflag"
      @board[pos].flagged = false
    else
      lost if @board[pos].value == "B"
      reveal_neighbors(pos)
    end
  end

  def reveal_neighbors(pos)
    @board[pos].revealed = true
    return [] unless @board[pos].value == 0
    neighbors = @board.find_neighbors(pos)

    neighbors.each { |n| reveal_neighbors(n) unless @board[n].revealed }
  end

  def lost
    puts "You lost!"
    render_finished_board
    exit
  end

  def render_finished_board
    (0..8).each do |x|
      (0..8).each do |y|
        @board[[x,y]].revealed = true
      end
    end
    @board.render
  end

  def won?
    (0..8).each do |x|
      (0..8).each do |y|
        check = @board[[x,y]].revealed == true || @board[[x,y]].value == "B"
        return false unless check
      end
    end
    true
    render_finished_board
  end

  def save
    File.open('savedgame.txt', 'w') { |f| f.write(YAML.dump(self)) }
    exit
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Load game? (y/n)"
  answer = gets.chomp
  if answer == 'y'
    g = YAML.load(File.read('savedgame.txt'))
    g.run
  else
    g = Game.new
    g.run
  end
end
