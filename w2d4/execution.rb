def my_min(array)
  min = array.first
  array.each_with_index do |el, i|
    j = i + 1
    array[j..-1].each do |el2|
      min = el2 if el2 < min
    end
  end
  min
end

def my_min_better(array)
  min = array.first
  array.each_with_index do |el, i|
    next if el > min
    min = el if el < min
  end
  min
end

def largest_cont(array)
  subs = []

  1.upto(array.length) do |i|
    array.each_cons(i) do |sub_array|
      subs << sub_array
    end
  end

  sums = subs.map do |sub_arr|
    sub_arr.inject(:+)
  end

  sums.max
end


def largest_cont_better(array)
  max = array.first
  current_running_sum = array.first

  array[1..-1].each_with_index do |el, i|
    current_running_sum += el
    if current_running_sum > max
      max = current_running_sum
    elsif current_running_sum < 0
      current_running_sum = 0
    end
  end

  max
end
