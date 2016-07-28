require_relative 'piece'
require_relative 'slider'

class Queen < Piece
  include Slider

  def initialize(board, color, pos)
    super
  end

  def to_s
    " #{symbol} "
  end


  def symbol
    '♛'.colorize(color)
  end



  MOVE_DIRS = [
    [1,0],
    [-1,0],
    [0,-1],
    [0,1],
    [1,-1],
    [1,1],
    [-1,-1],
    [-1,1]]
end#subclass
