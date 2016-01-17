class Node
  attr_reader :value
  attr_accessor :parent_node, :left_node, :right_node

  def initialize(value)
    @value = value
  end
  
  def add(new_value)
    if new_value < @value 
      if @left_node
        @left_node.add(new_value)
      else
        @left_node = Node.new(new_value)
      end
    elsif new_value > @value
      if @right_node
        @right_node.add(new_value)
      else
        @right_node = Node.new(new_value)
      end
    end
  end
end

def build_tree_sorted(arr)
  half = arr.size / 2
  root = Node.new(arr[half])
  return root if arr.size <= 1

  root.left_node = build_tree_sorted(arr[0...half])
  root.right_node = build_tree_sorted(arr[half+1..-1])

  root
end

def build_tree(arr)
  root = Node.new(arr.shift)
  arr.each { |n| root.add(n)}
  root
end

def breadth_first_search(value, tree)
  queue = [tree]
  until queue.size == 0
    current = queue.shift
    return current.value if current.value == value
    queue << current.left_node if current.left_node != nil
    queue << current.right_node if current.right_node != nil
  end
  nil
end

def depth_first_search(value, tree)
  stack = [tree]
	until stack.empty?
		current_node = stack.pop
		return current_node.value if value == current_node.value
		stack << current_node.left_node unless current_node.left_node.nil?
		stack << current_node.right_node unless current_node.right_node.nil?
	end
	nil
end

def dfs_rec(value, current_node)
	return current_node.value if value == current_node.value
	unless current_node.left_node.nil?
		result = dfs_rec(value, current_node.left_node)
		return result unless result.nil?
	end
	unless current_node.right_node.nil?
		result = dfs_rec(value, current_node.right_node)
		return result unless result.nil?
	end
	nil
end

def draw(tree)
  queue = [tree]
  until queue.empty?
    current_node = queue.shift
    puts "    Node: #{current_node.value}"
 	  left_child = current_node.left_node.nil? ? " - " : current_node.left_node.value
  	right_child = current_node.right_node.nil? ? " - " : current_node.right_node.value
    puts "Children: #{left_child}, #{right_child}"
		queue << current_node.left_node if !current_node.left_node.nil?
		queue << current_node.right_node if !current_node.right_node.nil?
  end
end

#draw(build_tree_sorted([1,2,3,4,5,6,7,8,9,10,11,12]))

a = [10,9,25,8,17,6,75,2,1,35,52,40]
a.shuffle!
t = build_tree(a)
draw(t)
puts "Searching... #{breadth_first_search(6, t)}"
puts "Searching... #{depth_first_search(6, t)}"
puts "Searching... #{dfs_rec(6, t)}"
