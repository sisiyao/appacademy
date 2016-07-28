
class Player
    attr_reader :color

    def initialize(color, display, board)
      @color = color
      @display = display
      @board = board
    end

    def get_pos
      @display.render
      pos = nil
      until pos
        pos = @display.get_input
        @display.render
      end
      pos
    end

    def get_start_pos
      pos = nil
      until pos
        pos = get_pos
        (pos = nil; next) unless @board[pos].is_a? Piece
        (pos = nil; next) unless @board[pos].color == @color
        (pos = nil; next) unless @board[pos].moves(pos).length > 0
      end
      @display.selected = pos
      @display.render
      pos
    end

    def get_end_pos(start_pos)
      pos = nil
      until pos
        pos = get_pos
        (pos = nil; next) unless @board[start_pos].moves(start_pos).include?(pos)
      end
      p pos
    end

    def get_move
      start = get_start_pos
      fin = get_end_pos(start)
      #check if in check
      @display.selected = nil
      [start,fin]
    end



end#class
