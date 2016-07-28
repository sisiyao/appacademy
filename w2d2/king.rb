require_relative 'piece'
require_relative 'stepper'

class King < Piece
  include Stepper
  def initialize(board, color, pos)
    super
  end


  def to_s
    " #{symbol} "
  end



  def symbol
    'K'.colorize(color)
  end

    MOVES = [
      [ 0,-1],
      [ 0, 1],
      [-1, 0],
      [ 1, 0],
      [ 1,-1],
      [-1,-1],
      [ 1, 1],
      [-1, 1]
    ]

end#subclass
