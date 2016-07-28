require_relative 'p02_hashing'
require 'byebug'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(el)
    if @count == num_buckets
      resize!
    end
    bucket = self[el]
    @store[bucket].push(el) unless include?(el)
    @count += 1
  end

  def include?(el)
    bucket = self[el]
    @store[bucket].include?(el)
  end

  def remove(el)
    bucket = self[el]
    @store[bucket].delete(el)
    @count -= 1
  end

  private

  def [](el)
    el.hash % num_buckets
    # optional but useful; return the bucket corresponding to `el`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(@store.length * 2){ Array.new }
    @store.each do |bucket|
      bucket.each do |item|
        bucket = item % (num_buckets * 2)
        new_store[bucket] << item
      end
    end
    @store = new_store
  end
end

# h = HashSet.new
#
#
# h.insert(50)
# p h.include?(50)
# # h.insert("howdy")
# h.insert([])
# p h.include?([])
# h.insert({:a => 3, :b => 4})
# p h.include?
#
# expect(set.include?(50)).to be(true)
# expect(set.include?(49)).to be(false)
#
# expect(set.include?("howdy")).to be(true)
# expect(set.include?(:howdy)).to be(false)
#
# expect(set.include?([])).to be(true)
# expect(set.include?([[]])).to be(false)
#
# expect(set.include?({:a => 3, :b => 4})).to be(true)
# expect(set.include?({:b => 4, :a => 3})).to be(true)
