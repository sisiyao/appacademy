class PolyTreeNode
  attr_reader :children, :value, :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def to_s
    { value: @value,
      parent_value: @parent ? @parent.value : nil,
      children: @children.map { |child| child.value }
    }
  end

  def parent=(parent_node)
    @parent.children.delete(self) if self.parent
    @parent = parent_node
    parent_node.children << self unless parent_node.nil? || parent_node.children.include?(self)
  end

  def add_child(child_node)
    @children << child_node
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "not a child" unless @children.include?(child_node)
    @children.delete(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value==target_value
    @children.each do |child|
      result=child.dfs(target_value)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    return self if self.value == target_value
    until queue.empty?
      queue.shift.children.each do |child|
        return child if child.value == target_value
        queue << child
      end
    end
    nil
  end
end
