class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store << el
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end
end

class MyStack
  attr_reader :min, :max, :store

  def initialize
    @store = []
  end

  def pop
    popped = @store.pop
    if @store.size > 0
      @max = @store.max
      @min = @store.min
    else
      @min = nil
      @max = nil
    end

    popped
  end

  def push(el)
    if @store.empty?
      @max = el
      @min = el
    elsif el > max
      @max = el
    elsif el < min
      @min = el
    end

    @store << el
  end

  def peek
    @store.last
  end

  def size
    @store.size
  end

  def empty?
    @store.empty?
  end
end

class StackQueue
  attr_reader :min, :max, :in_stack, :out_stack

  def initialize
    @in_stack = MyStack.new
    @out_stack = MyStack.new
    @max = nil
    @min = nil
  end

  def enqueue(el)
    if @max.nil?
      @min = el
      @max = el
    else
      @max = ( el > @max ? el : @max )
      @min = ( el < @min ? el : @min )
    end
    @in_stack.push(el)
  end

  def dequeue
    flip if @out_stack.empty?
    @out_stack.pop
    if @in_stack.max.nil?
      curr_max = @out_stack.max
      curr_min = @out_stack.min
    elsif @out_stack.max.nil?
      curr_max = @in_stack.max
      curr_min = @in_stack.min
    else
      #require 'byebug'; debugger
      curr_max = @in_stack.max > @out_stack.max ? @in_stack.max : @out_stack.max
      curr_min = @in_stack.min > @out_stack.min ? @in_stack.min : @out_stack.min
    end
    @max = curr_max#( curr_max > @max ? curr_max : @max )
    @min = curr_min#( curr_min > @min ? curr_min : @min )
  end

  def flip
    until @in_stack.empty?
      @out_stack.push(@in_stack.pop)
    end
  end

  def size
    @in_stack.size + @out_stack.size
  end

  def empty?
    @in_stack.size + @out_stack.size == 0
  end
end

# a = StackQueue.new
# a.enqueue(5)
# a.enqueue(3)
# a.enqueue(2)
# a.dequeue
# p a.in_stack
# p a.out_stack
# p a.max
