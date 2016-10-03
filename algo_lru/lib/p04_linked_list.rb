class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = Link.new
  end

  def [](i)
    each_with_index { |link, j|
      return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == nil
  end

  def get(key)
    curr_link = @head
    loop do
      if curr_link.key == key
        return curr_link.val
      elsif curr_link.next == nil
        return nil
      else
        curr_link = curr_link.next
      end

    end
  end

  def include?(key)
    get(key) != nil
  end

  def insert(key, val)
    link = Link.new(key, val)
    if self.empty?
      @tail.prev = link
      @head.next = link
      link.prev = @head
      link.next = @tail
    elsif self.include?(key)
      self.each do |link|
        link.val = val if link.key == key
      end
    else
      old_prev = @tail.prev
      @tail.prev = link
      link.prev = old_prev
      link.next = @tail
      old_prev.next = link
    end
    link
  end

  def remove(key)
    self.each do |link|
      if link.key == key
         link_prev = link.prev #head
         link_next = link.next  #second
         link_next.prev = link_prev  #set second prev to head
         link_prev.next = link_next   #
         return key
      end
    end
  end

  def each(&prc)
    return self if self.empty?
    curr_link = @head.next
    loop do
      prc.call(curr_link)
      break if curr_link.next.next == nil
      curr_link = curr_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
