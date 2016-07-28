require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    got = @map.get(key)
    if got.nil?
      calc!(key)
      eject! if @max == @map.count
    else
      update_link!(got)
    end
    @store.get(key)
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    sq = @prc.call(key)
    link = @store.insert(key, sq)
    @map.set(key, link)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.remove(link.key)
    @store.insert(link.key, link.val)
  end

  def eject!
    num = @store.head.next.key
    @store.remove(num)
    @map.delete(num)
  end
end
