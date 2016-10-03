require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @capacity = capacity
    @length = 0
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' unless check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise 'index out of bounds' unless check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @length -= 1
    @store[@length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0
    val = @store[0]
    (1...@length).each {|i| @store[i - 1] = @store[i]}
    @length -= 1
    val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    @length.times {|i| @store[@length - i] = @store[@length - i - 1]}
    @length += 1
    @store[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    index.between?(0, @length - 1)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_store = StaticArray.new(@capacity * 2)
    @length.times {|i| new_store[i] = @store[i]}
    @capacity = @capacity * 2
    @store = new_store
  end
end
