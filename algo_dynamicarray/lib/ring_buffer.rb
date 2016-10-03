require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @capacity = capacity
    @length = 0
    @start_idx = 0
  end

  def idx(i)
    (@start_idx + i) % @capacity
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' unless check_index(index)
    @store[idx(index)]
  end

  # O(1)
  def []=(index, val)
    raise 'index out of bounds' unless check_index(index)
    @store[idx(index)] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @length -= 1
    @store[idx(@length)]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[idx(@length)] = val
    @length += 1
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length == 0
    val = @store[idx(0)]
    @start_idx = idx(1)
    @length -= 1
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @length += 1
    @start_idx = idx(-1)
    @store[@start_idx] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    index.between?(0, @length - 1)
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)
    @length.times {|i| new_store[i] = @store[idx(i)]}
    @capacity = @capacity * 2
    @store = new_store
    @start_idx = 0
  end
end
