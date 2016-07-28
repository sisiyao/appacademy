class Array
  def my_each(&prc)
    i=0
    while i < self.length
      prc.call(self[i])

      i += 1
    end
    self
  end

  def my_select(&prc)
    array = []
    self.my_each do |i|
      array << i if prc.call(i)
    end
    array
  end

  def my_reject(&prc)
    array = []
    self.my_each do |i|
      array << i unless prc.call(i)
    end
    array
  end

  def my_any?(&prc)
    self.my_each do |i|
      return true if prc.call(i)
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |i|
      return false unless prc.call(i)
    end
    true
  end

  def my_flatten
    flat_array = []
    self.my_each do |i|
      if i.class == Array
        metarray = i.my_flatten
        flat_array += metarray
      else
        flat_array << i
      end
    end
    flat_array
  end

  def my_zip(*args)
    grid = [self, *args]
    columns = self.length
    zip = []
    (0...columns).each do |col|
      zip_row = []
      grid.each do |row|
        zip_row << row[col]
      end
      zip << zip_row
    end
    zip
  end

  def my_rotate(num=1)
    if num > 0
      num.times do |_|
        first = self.shift
        self << first
      end
    else
      num = -num
      num.times do |_|
        first = self.pop
        self.unshift(first)
      end
    end

    self
  end

  def my_join(separator = "")
    str = ""
    self.my_each do |chr|
      str += chr + separator
    end
    unless separator.empty?
      str = str[0...-1]
    end
    str
  end

  def my_reverse
    i = 0
    until i == self.length / 2
      self[i], self[-(i+1)] = self[-(i+1)], self[i]

      i += 1
    end
    self
  end
end
