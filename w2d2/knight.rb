require_relative 'piece'
require_relative 'stepper'

class Knight < Piece
  include Stepper
  def initialize(board, color, pos)
    super
  end


  def to_s
    " #{symbol} "
  end

  def symbol
    '♞'.colorize(color)
  end

  MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

end#subclass
