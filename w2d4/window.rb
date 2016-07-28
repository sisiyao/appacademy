require_relative 'stack'

def windowed_max(array, window)
  current_max_range = array[0] - array[window]
  array.each_cons(window) do |sub_array|
    range = sub_array.max - sub_array.min
    current_max_range = range if range > current_max_range
  end
  current_max_range
end

def windowed_max_range(array, window)
  current_max_range = nil
  processor = StackQueue.new

  array.each do |el|
    if processor.size < window
      processor.enqueue(el)
    elsif processor.size == window

      current_range = processor.max - processor.min

      if current_max_range.nil?
        current_max_range = current_range
      elsif current_range > current_max_range
        current_max_range = current_range
      end

      processor.dequeue
      processor.enqueue(el)
    end
  end

  p processor.in_stack
  p processor.out_stack

  current_range = processor.max - processor.min
  current_max_range = current_range if current_max_range.nil? || current_range > current_max_range


  current_max_range
end

# p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4)
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
