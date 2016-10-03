class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @left = nil
    @right = nil
    @value = value
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    @root.nil? ? @root = BSTNode.new(value) : self.class.insert!(@root, value)
  end

  def find(value)
    self.class.find!(@root, value)
  end

  def inorder
    self.class.inorder!(@root)
  end

  def postorder
    self.class.postorder!(@root)
  end

  def preorder
    self.class.preorder!(@root)
  end

  def height
    self.class.height!(@root)
  end

  def min
    self.class.min(@root)
  end

  def max
    self.class.max(@root)
  end

  def delete(value)
    self.class.delete!(@root, value)
  end

  def self.insert!(node, value)
    return node = BSTNode.new(value) if node.nil?
    new_node = BSTNode.new(value)
    insert_node = node
    side = nil
    until insert_node.nil?
      prev_node = insert_node
      if value <= insert_node.value
        insert_node = insert_node.left
        side = "left"
      else
        insert_node = insert_node.right
        side = "right"
      end
    end
    side == "left" ? prev_node.left = new_node : prev_node.right = new_node
    node
  end

  def self.find!(node, value)
    until node.nil? || node.value == value
      if value <= node.value
        node = node.left
      else
        node = node.right
      end
    end
    node
  end

  def self.preorder!(node)
    return [] unless node

    arr = [node.value]
    arr += BinarySearchTree.preorder!(node.left) if node.left
    arr += BinarySearchTree.preorder!(node.right) if node.right

    arr
  end

  def self.inorder!(node)
    return [] unless node

    arr = []
    arr += BinarySearchTree.inorder!(node.left) if node.left
    arr << node.value
    arr += BinarySearchTree.inorder!(node.right) if node.right

    arr
  end

  def self.postorder!(node)
    return [] unless node

    arr = []
    arr += BinarySearchTree.postorder!(node.left) if node.left
    arr += BinarySearchTree.postorder!(node.right) if node.right
    arr << node.value

    arr
  end

  def self.height!(node)
    return -1 if node.nil?
    height = 0
    stack = [[node, 0]]
    visited_levels = [0]
    until stack.empty?
      el = stack.pop
      level = el.last
      if !visited_levels.include?(level)
        height += 1
        visited_levels << level
      end
      [el.first.left, el.first.right].each do |node|
        next if node.nil?
        stack << [node, level + 1]
      end
    end
    height
  end

  def self.max(node)
    until node.right.nil?
      node = node.right
    end
    node
  end

  def self.min(node)
    until node.left.nil?
      node = node.left
    end
    node
  end

  def self.delete_min!(node)
    return nil if node.nil? || (node.left.nil? && node.right.nil?)
    prev_node = nil
    until node.left.nil?
      prev_node = node
      node = node.left
    end
    if prev_node.nil?
      node.right ? node.right = nil : return
    else
      node.right ? prev_node.left = node.right : prev_node.left = nil
    end
  end

  def self.delete!(node, value)
    return nil if node.nil?
    return nil if node.value == value && node.left.nil? && node.right.nil?
    until node.nil? || node.value == value
      prev_node = node
      if value <= node.value
        side = "left"
        node = node.left
      else
        side = "right"
        node = node.right
      end
    end
    return nil if node.nil?
    if node.right.nil? && node.left.nil?
      side == "left" ? prev_node.left = nil : prev_node.right = nil
    elsif node.right.nil? ^ node.left.nil?
      if node.right
        side == "left" ? prev_node.left = node.right : prev_node.right = node.right
      else
        side == "left" ? prev_node.left = node.left : prev_node.right = node.left
      end
    else
      min = self.min(node.right)
      self.delete_min!(node)
      side == "left" ? prev_node.left = min : prev_node.right = min
      min.left = node.left
      min.right = node.right
    end
  end
end
