class Board
  attr_reader :rows

  def initialize
    @rows = Array.new(8){Array.new(8){NullPiece.instance}}
    initial_grid
  end

  def [](pos)
    x,y = pos
    @rows[x][y]
  end

  def []=(pos, mark)
    x,y = pos
    @rows[x][y]=mark
  end

  def move(start, fin)
    piece = self[start]
    self[start] = NullPiece.instance
    self[fin] = piece

  end

  def in_bounds?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end
############################ new methods

  def initial_grid
    # debugger
    color = :black
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    2.times do

      i = (color == :white) ? 7 : 0
      back_row.each_with_index do |pclass, j|
        pclass.new(self, color, [i, j])
      end
      i = (color == :white) ? 6 : 1
      8.times do |j|
        Pawn.new(self, color, [i, j])
      end
      color = :white
      # back_row = back_row.reverse
    end
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def in_check?(color)
    # debugger
    king_location = king_locator(color)
    @rows.each_with_index do |row, r|
      row.each_with_index do |piece, c|
        next if piece.is_a? NullPiece || piece.color == color
        # debugger
        return true if piece.moves([r,c]).include?(king_location)
      end
    end
    false
  end


  def king_locator(color)
    # debugger
    @rows.each_with_index do |row, r|
      row.each_with_index do |piece, c|
        next if (piece.is_a? NullPiece) || (piece.opposite_color == color)
        return [r,c] if piece.is_a?(King)
      end
    end
    nil
  end



end#class
