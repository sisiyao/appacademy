def sum_recur(array)
  return nil if array.empty?
  return array.first if array.length == 1
  sum_recur(array[1..-1]) + array[0]
end

def includes?(array, target)
  return false if array.empty?
  return true if array.first == target
  false || includes?(array[1..-1], target)
end

def num_occur(array, target)
  return 0 if array.empty?
  if array.first == target
    return 1 + num_occur(array[1..-1],target)
  else
    0 + num_occur(array[1..-1],target)
  end
end

def add_to_twelve(array)
  return false if array.length < 2
  if array[0] + array[1] == 12
    return true
  else
    false || add_to_twelve(array[1..-1])
  end
end

def sorted?(array)
  return true if array.length < 2
  if array[0] > array[1]
    return false
  else
    true && sorted?(array[1..-1])
  end
end

def reverse(number)
  return number.to_s if number < 10
  (number % 10).to_s + reverse(number/10)
end
