require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  BOARD_POS = [[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]]

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    new_next_mover_mark = @next_mover_mark == :x ? :o : :x

    BOARD_POS.each do |pos|
      next if @board[pos]
      new_board = @board.dup
      new_prev_move_pos = pos
      children << TicTacToeNode.new(new_board, new_next_mover_mark, new_prev_move_pos)
    end
    children
  end

  def board_full?
    @board.flatten.all? { |pos| pos }
  end

  def losing_node?(mark)
    return true unless @board.winner == mark || @board.tied?

    children.each do |child|
      loser = child.losing_node?(mark)
      return true if loser
    end

    false
  end





end
