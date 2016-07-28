require_relative 'piece'


module Slider
  def moves(pos)
    # debugger
    valid_moves = []
    r,c = pos
    self.class::MOVE_DIRS.each do |shift|
      # debugger
      r_shift, c_shift = shift[0], shift[1]
      curr_move = [r + r_shift, c + c_shift]
      while @board.in_bounds?(curr_move)
        move_color = @board[curr_move].color
        break if move_color == self.color
        valid_moves << curr_move
        break if move_color == self.opposite_color
        curr_move = [curr_move[0] + r_shift, curr_move[1] + c_shift]
      end
    end
    valid_moves
  end

end#subclass

class Bishop < Piece
  include Slider

  def initialize(board, color, pos)
    super
  end

  def to_s
    " #{symbol} "
  end


  def symbol
    '♝'.colorize(color)
  end

  MOVE_DIRS = [
    [1,-1],
    [1,1],
    [-1,-1],
    [-1,1]]
end#subclass

class Rook < Piece
  include Slider

  def initialize(board, color, pos)
    super
  end

  def to_s
    " #{symbol} "
  end


  def symbol
    '♜'.colorize(color)
  end

  MOVE_DIRS = [
    [1,0],
    [-1,0],
    [0,-1],
    [0,1]]
end#subclass

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
