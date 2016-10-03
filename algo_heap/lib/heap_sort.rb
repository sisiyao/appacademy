require_relative "heap"

class Array
  def heap_sort!
    boundary = 1
    while boundary < self.length
      BinaryMinHeap.heapify_up(self, boundary)
      boundary += 1
    end

    boundary = self.length - 1
    while boundary >= 0
      self[0], self[boundary] = self[boundary], self[0]
      boundary -= 1
      BinaryMinHeap.heapify_down(self, 0, boundary + 1)
    end

    self.reverse!
  end
end
