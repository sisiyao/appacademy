def range(start, end_point)
  return [] if end_point <= start+1
  [start+1] + range(start+1, end_point)
end

def sum_iterative(arr)
  sum = 0
  arr.each { |el| sum += el }
  sum
end

def sum_recursive(arr)
  return nil if arr.empty?
  return arr.first if arr.length == 1
  sum_recursive(arr[1..-1]) + arr.first
end

def exp_one(base, pow)
  return nil if pow < 0
  return 1 if pow == 0
  exp_one(base, pow-1) * base
end

def exp_two(base, pow)
  return 1 if pow == 0
  return base if pow == 1
  return exp_two(base, pow/2) ** 2 if pow % 2 == 0
  base * (exp_two(base, (pow - 1)/2) ** 2)
end

class Array
  def deep_dup
    #iterate through self
    copy = []
    self.each do |el|
      if el.is_a?(Array)
        copy << el.deep_dup
      else
        copy << el
      end
    end
    copy
  end
end

def fibonacci_iterative(n)
  array = [1, 1]
  (1...n-1).each do |i|
    array << array[i] + array[i - 1]
  end

  array
end

def fibonacci_rec(n)
  return nil if n <= 0
  return [1] if n == 1
  return [1, 1] if n == 2
  prev = fibonacci_rec(n-1)
  last_el = [prev[-1] + prev[-2]]
  prev + last_el
end

def binary_search(sorted_arr, target)
  mid = sorted_arr.length / 2

  return mid if target == sorted_arr[mid]
  return nil if target != sorted_arr[mid] && sorted_arr.length == 1

  if target < sorted_arr[mid]
    binary_search(sorted_arr[0...mid], target)
  else
    binary_search(sorted_arr[mid+1..-1], target) + mid + 1
  end
end

def merge_sort(arr)
  return arr if arr.length <= 1

  mid = arr.length/2
  lhs = merge_sort(arr[0...mid])
  rhs = merge_sort(arr[mid..-1])

  merge(lhs, rhs)
end

def merge(lhs, rhs)
  merged_arr = []

  until lhs.empty? || rhs.empty?
    smaller = lhs[0] < rhs[0] ? lhs : rhs
    merged_arr << smaller.shift
  end

  merged_arr + lhs + rhs
end

class Array
  def subsets
    return [[]] if self.empty?
    sub_array = self.take(length - 1).subsets
    sub_array.set(self[-1])
  end

  def set(num)
    add = []
    self.each do |el|
      new_el = el + [num]
      add << new_el
    end
    self + add
  end
end
