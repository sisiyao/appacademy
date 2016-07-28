# require "byebug"
def factors(num)
  factors = []
  (1..num).each { |i| factors << i if num % i == 0 }
  factors
end

class Array
  def bubble(&prc)
    (0...self.length - 1).each do |i|
      if prc.call(self[i], self[i + 1]) == 1
        self[i], self[i + 1] = self[i + 1], self[i]
      end
    end
    self
  end

  def sorted?(&prc)
    !((0...self.length - 1).any? { |i| prc.call(self[i], self[i + 1]) == 1})
  end

  def bubble_sort!(&prc)
    # debugger
    if prc.nil?
      bubble_sort! { |x, y| x <=> y }
    else
      until sorted?(&prc)
        bubble(&prc)
      end
    end
    self
  end

  def bubble_sort(&prc)
    a = dup
    a.bubble_sort!(&prc)
  end
end

def substrings(string)
  array = []
  (0...string.length).each do |i|
    (i...string.length).each do |j|
      array << string[i..j]
    end
  end
  array
end

def subwords(word, dictionary)
  array = []
  substrings(word).each do |sub|
    array << sub if dictionary.include?(sub)
  end
  array.uniq
end

def doubler(array)
  array.map do |i|
    i*2
  end
end
