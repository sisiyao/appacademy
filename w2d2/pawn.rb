require_relative 'piece'

class Pawn < Piece
  def initialize(board, color, pos)
    super
  end

  def symbol
    'P'.colorize(color)
  end

  def to_s
    " #{symbol} "
  end

  MOVES = [
    [1, 0],
    [1, 1],
    [1, -1]
  ]

  def moves(pos)
    valid_moves = []
    r, c = pos

    self.class::MOVES.each_with_index do |dir, index|
      r_shift, c_shift = dir[0], dir[1]
      curr_move = [r + direction * r_shift, c + direction * c_shift]
      if index > 0
        next unless @board.in_bounds?(curr_move)
        next unless @board[curr_move].color == @opposite_color
        valid_moves << curr_move
      else
        next unless @board.in_bounds?(curr_move)
        valid_moves << curr_move if @board[curr_move].color == nil
      end
    end

    valid_moves
  end

  def starting_row
    @color == :black ? 1 : 6
  end

  def direction
    @color == :black ? 1 : -1
  end
end#subclass
