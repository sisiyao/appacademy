class Tile
  attr_accessor :value, :revealed, :flagged

  def initialize
    @value = nil
    @revealed = false
    @flagged = false
  end

  def reveal
    @revealed = true
  end

end
