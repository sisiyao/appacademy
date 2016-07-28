class Array
  def my_uniq
    uniq = []

    self.each do |el|
      uniq << el unless uniq.include?(el)
    end

    uniq
  end

  def two_sum
    pairs = []

    (0...self.length - 1).each do |i|
      j = i + 1
      (j...self.length).each do |j|
        pairs << [i, j] if self[i] + self[j] == 0
      end
    end

    pairs
  end
end

def my_transpose(array)
  result = []

  array.each_with_index do |row, i|
    sub_array = []

    row.each_index do |j|
      sub_array << array[j][i]
    end

    result << sub_array
  end

  result
end

def stock_picker(array)
  diffest_pair = nil
  biggest_diff = nil

  (0...array.length - 1).each do |i|
    j = i + 1
    (j...array.length).each do |j|
      diff = array[j] - array[i]
      if biggest_diff.nil? || diff > biggest_diff
        biggest_diff = diff
        diffest_pair = [i, j]
      end
    end
  end

  diffest_pair
end
