require_relative 'board'
require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'null_piece'
require_relative 'pawn'
require_relative 'piece'
require_relative 'queen'
require_relative 'rook'
require_relative 'display'
require_relative 'player'

require 'byebug'
#require_relative 'pawns'

class Game
  attr_reader :board, :display, :player_black, :player_white

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player_black = Player.new(:black, @display, @board)
    @player_white = Player.new(:white, @display, @board)
    @current_player = @player_white
  end

  def switch_player
    @current_player == @player_white ? @current_player = @player_black : @current_player = @player_white
  end



  def play

    until check_mate
      valid_moves = false
      until valid_moves
        valid_moves = get_valid_moves
      end
      @display.render
      switch_player
    end

  end

  def get_valid_moves
    start,fin =  @current_player.get_move
    piece_at_fin = @board[fin]
    @board.move(start, fin)
    not_in_check(start, fin, piece_at_fin)
  end

  def not_in_check(start, fin, piece_at_fin)
    if @board.in_check?(@current_player.color)
      @board.move(fin, start)
      @board[fin] = piece_at_fin
      false
    else
      true
    end
  end

  def check_mate
    return false unless @board.in_check?(@current_player.color)
    apm = all_possible_moves.dup + [1] - [1]
    all_possible_moves.each do |move|
      start,fin =  move
      piece_at_fin = @board[fin]
      @board.move(start, fin)
      if not_in_check(start, fin, piece_at_fin)
        debugger
        @board.move(fin, start)
        @board[fin] = piece_at_fin
      else
        apm.shift
      end
    end
    apm = [] ? true : false
  end

  def all_possible_moves
    results = []
    @board.rows.each_with_index do |row, r|
      row.each_with_index do |piece, c|
        next if piece.color != @current_player.color
        current_start = [r,c]
        all_piece_moves = piece.moves([r,c]) if piece.color == @current_player.color
        all_piece_moves.each do |fin|
          results << [current_start, fin]
        end
      end
    end
    results
  end

end#class

a = Game.new
a.play


# puts a.in_check?(:white)
# p a.king_locator(:white)
#
# p a.king_locator(:black)
# p a.in_check?(:white)
