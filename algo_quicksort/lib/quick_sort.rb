class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    lhs = []
    rhs = []
    (1...array.length).each do |i|
      el = array[i]
      lhs << el if el < pivot
      rhs << el if el >= pivot
    end
    QuickSort.sort1(lhs) + [pivot] + QuickSort.sort1(rhs)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length <= 1
    pivot_idx = self.partition(array, start, length, &prc)
    self.sort2!(array, 0, pivot_idx - start, &prc)
    self.sort2!(array, pivot_idx + 1, start + length - pivot_idx - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc = Proc.new { |x, y| x <=> y } if prc == nil
    i = start + 1
    pivot_idx = start
    until i >= start + length
      if prc.call(array[i], array[pivot_idx]) == -1
        array[i], array[pivot_idx + 1] = array[pivot_idx + 1], array[i]
        array[pivot_idx + 1], array[pivot_idx] = array[pivot_idx], array[pivot_idx + 1]
        pivot_idx += 1
      end
      i += 1
    end
    pivot_idx
  end
end
