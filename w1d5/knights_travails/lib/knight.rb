require_relative '00_tree_node'

class KnightPathFinder

  def initialize(start_pos = [0, 0])
    @start_node = PolyTreeNode.new(start_pos)
    @visited_position = [start_pos]
    @start_pos = start_pos
  end

  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos).reject{|move| @visited_position.include?(move)}
    @visited_position += new_moves
    new_moves
  end

  def self.valid_moves(pos)
    positions = [[pos[0] + 1, pos[1] + 2],
                [pos[0] + 1, pos[1] - 2],
                [pos[0] - 1, pos[1] + 2],
                [pos[0] - 1, pos[1] - 2],
                [pos[0] + 2, pos[1] + 1],
                [pos[0] + 2, pos[1] - 1],
                [pos[0] - 2, pos[1] + 1],
                [pos[0] - 2, pos[1] - 1]]
    positions.select {|pos| pos[0].between?(0, 7) && pos[1].between?(0, 7)}
  end

  def build_move_tree
    queue = [@start_node]
    until queue.empty?
      curr_node = queue.shift
      new_moves = new_move_positions(curr_node.value)
      new_moves.each do |move|
        child_node = PolyTreeNode.new(move)
        curr_node.add_child(child_node)
        queue << child_node
      end
    end
  end

  def find_path(end_pos)
    tree = build_move_tree
    target_node = @start_node.dfs(end_pos)
    path = [target_node]

    until path.include?(@start_node)
      par=path.first.parent
      path.unshift(par)
    end

    path.map{|node| node.value}
  end

  attr_reader :start_node
end


a = KnightPathFinder.new([0,0])
# a.build_move_tree
# p a.start_node.to_s
# p a.start_node.children[0].to_s

p a.find_path([3,3])
