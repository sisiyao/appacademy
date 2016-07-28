def two_sums(arr, target_sum)
  arr_hash = Hash.new(0)
  arr.each do |el|
    arr_hash[el] = target_sum - el
  end
  arr_hash.each do |k, v|
    return true if arr_hash.has_key?(v)
  end
  false
end
#O(n)

def two_sums_sort(arr, target_sum)
  arr.sort!

  arr.each do |el|
    return true if arr.bsearch{ |el2| el2 == target_sum - el }
  end

  false
end

def four_sums(arr, target_sum)
  arr_hash = Hash.new(0)
  arr.each do |el|
    arr_hash[el] = target_sum - el
  end
  arr_hash.each do |k, v|
    return true if arr_hash.has_key?(v)
  end
  false
end
