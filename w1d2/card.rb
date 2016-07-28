class Card
  attr_reader :value, :face_up

  def initialize value
    @value = value
    @face_up = false
  end

  def display
    return @value if @face_up
    nil
  end

  def hide
    @face_up = false if @face_up
  end

  def reveal
    @face_up = true unless @face_up
    @value
  end
end
