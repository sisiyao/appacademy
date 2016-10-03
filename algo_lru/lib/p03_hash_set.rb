require_relative 'p02_hashing'

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
