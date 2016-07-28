require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 0.hash + 1 if self.empty?
    hashed = self.map.with_index do |num, idx|
      if num.is_a?(Array)
        0.hash + 1
      else
        num + idx
      end
    end
    xor = 1
    prime_xor = [2_147_483_647, 6_700_417, 524_287]
    hashed.each_with_index do |el, idx|
      key = idx % prime_xor.length
      if idx == hashed.length - 1 && hashed.length % prime_xor.length == 0
        xor = xor ^ el
        break
      end
      xor = xor ^ (el^prime_xor[key])
    end
    xor
  end
end

class String
  def hash
    hashed = self.split("").map.with_index{ |char, idx| char.ord + idx }
    xor = 1
    prime_xor = [2_147_483_647, 6_700_417, 524_287]
    hashed.each_with_index do |el, idx|
      key = idx % prime_xor.length
      if idx == hashed.length - 1 && hashed.length % prime_xor.length == 0
        xor = xor ^ el
        break
      end
      xor = xor ^ (el^prime_xor[key])
    end
    xor
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys = self.keys.map{ |el| el.to_s.ord}.sort
    values = self.values.map{ |el| el.to_s.ord}.sort
    keys.hash + values.hash
  end
end
# a = [1,2,3]
# p a.hash
# b = [2,3,1]
# p b.hash
#
# p "foobar".hash
# p "foobat".hash
# p "sisi likes dogs".hash
#
# p hash = {a: "hello"}
# p hash.hash
