require_relative 'tile'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new (9) { Array.new(9) { Tile.new } }
    populate
  end

  def populate
    num_bombs = rand(5..15)

    num_bombs.times do
      pos = [rand(0..8), rand(0..8)]
      self[pos].value = "B"
    end

    (0..8).each do |x|
      (0..8).each do |y|
        set_value([x, y]) unless self[[x, y]].value == "B"
      end
    end
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def find_neighbors(cellpos)
    neighbors = []
    x,y = cellpos

    neighbors << [x, y - 1]
    neighbors << [x, y + 1]
    neighbors << [x + 1, y]
    neighbors << [x - 1, y]
    neighbors << [x + 1, y + 1]
    neighbors << [x + 1, y - 1]
    neighbors << [x - 1, y + 1]
    neighbors << [x - 1, y - 1]

    neighbors.reject { |el| el.any? { |x| x < 0 || x > 8 } }
  end

  def set_value(pos)
    neighbors = find_neighbors(pos)
    adj_bombs = neighbors.select { |cell| self[cell].value == "B" }
    value = adj_bombs.count
    self[pos].value = value
  end

  def render
    @grid.each do |row|
      current_row = row.map do |cell|
        if cell.flagged
          "F".colorize(:red)
        else
          cell.revealed ? cell.value.to_s.colorize(:blue) : "_".colorize(:yellow)
        end
      end
      puts "#{current_row.join('  ')}"
    end
  end
end
