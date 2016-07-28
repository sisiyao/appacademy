require_relative 'board'
require_relative 'piece'
require_relative 'null_piece'
require_relative 'display'
require_relative 'sliders'
require_relative 'steppers'
require 'byebug'
#require_relative 'pawns'

class Game
  def initialize
    @board = Board.new;
    @display = Display.new(a);
  end

  def play
    b.render

    until valid_move(cursor_move)
      cursor_move = @display.get_input
    end

end#class



puts a.in_check?(:white)
# p a.king_locator(:white)
#
# p a.king_locator(:black)
# p a.in_check?(:white)
