class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    val = @store.pop
    self.class.heapify_down(@store, 0, count, &@prc)
    val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(@store, count - 1, count, &@prc)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    child1 = 2*parent_index + 1
    child2 = 2*parent_index + 2
    if child1 > len - 1
      return []
    elsif child2 > len - 1
      return [child1]
    else
      return [child1, child2]
    end
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end
  
  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc = prc == nil ? prc = Proc.new { |el1, el2| el1 <=> el2 } : prc
    child_idxs = self.child_indices(len, parent_idx)
    swap = true
    until child_idxs[0] == nil || swap == false
      if child_idxs[1] == nil
        small_child_idx = child_idxs[0]
      else
        small_child_idx = prc.call(array[child_idxs[0]], array[child_idxs[1]]) == -1 ? child_idxs[0] : child_idxs[1]
      end
      swap = prc.call(array[small_child_idx], array[parent_idx]) == -1 ? true : false
      if swap == true
        array[small_child_idx], array[parent_idx] = array[parent_idx], array[small_child_idx]
        parent_idx, child_idxs = small_child_idx, self.child_indices(len, small_child_idx)
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc = prc == nil ? prc = Proc.new { |el1, el2| el1 <=> el2 } : prc
    return array if child_idx == 0
    parent_idx = self.parent_index(child_idx)
    swap = true
    until swap == false
      swap = prc.call(array[child_idx], array[parent_idx]) == -1 ? true : false
      if swap == true
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        return array if parent_idx == 0
        child_idx, parent_idx = parent_idx, self.parent_index(parent_idx)
      end
    end
    array
  end
end
