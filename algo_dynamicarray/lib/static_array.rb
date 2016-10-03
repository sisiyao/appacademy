# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length)
    @length = length
    @store = Array.new(length)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" unless index.between?(0, @length - 1)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" unless index.between?(0, @length - 1)
    @store[index] = value
  end

  protected
  attr_accessor :store
end
