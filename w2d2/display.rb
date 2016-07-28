require 'colorize'
require_relative "cursorable"

class Display
  include Cursorable
  attr_accessor :selected

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected = nil
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @selected
      bg = :yellow
    elsif [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end

    if @board[[i,j]].color == :black
      c = :white
    else
      c = :green
    end
    { background: bg, color: c }
  end

  def render
    system("clear")
    puts "Fill the grid!"
    puts "Arrow keys, WASD to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
  end




end#class
