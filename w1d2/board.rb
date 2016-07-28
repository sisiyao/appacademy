class Board
  attr_reader :grid

  def initialize grid
    @grid = grid
  end

  def create_cards
    cards = []
    (@grid.flatten.length / 2).times do |i|
      cards << Card.new(i)
      cards << Card.new(i)
    end
    cards.shuffle!
  end

  def populate
    cards = create_cards
    length = @grid.first.length
    @grid = cards.each_slice(length).inject([], :<<)
  end

  def render
    @grid.each do |row|
      puts row.map{ |card| card.display }
    end
  end

  def won?
    @grid.flatten.all? { |x| x.face_up }
  end

  def reveal pos
    row, col = pos
    @grid[row][col].value unless @grid[row][col].face_up
  end
end
