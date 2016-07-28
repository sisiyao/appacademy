require_relative 'piece'

module Stepper

  def moves(pos)
    valid_moves = []
    r,c = pos

    self.class::MOVES.each do |dirs|
      # debugger
      r_shift, c_shift = dirs[0], dirs[1]
      curr_move = [r + r_shift, c + c_shift]
      next unless @board.in_bounds?(curr_move)
      valid_moves << curr_move if @board[curr_move].color != self.color
    end
    valid_moves

  end

end#subclass

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
