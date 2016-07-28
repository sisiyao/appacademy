class Piece

  attr_reader :color, :current_pos, :opposite_color
  def initialize(board, color, current_pos) #:white  :black
    @board = board
    @color = color
    @opposite_color = color == :black ? :white : :black
    @current_pos = current_pos
    #black is always on top
    @board.add_piece(self, current_pos)
  end




  # def moves
  # end

end #class
