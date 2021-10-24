
class Tree
  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(sorted_array, start = 0, last = sorted_array.length - 1)
    return nil if start > last
    middle = (start + last) / 2
    root = Node.new(sorted_array[middle])
    root.left = build_tree(sorted_array, start, middle - 1 )
    root.right = build_tree(sorted_array, middle + 1, last)
    root
  end

  def insert(val,root = @root)
    return Node.new(val) if root == nil
    val > root.data ? root.right = insert(val, root.right) : root.left = insert(val, root.left)
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

class Node
  attr_accessor :left, :right, :data
  def initialize(data = nil)
    @left = @right = nil
    @data = data
  end
end

t1 = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
t1.pretty_print
t1.insert(20)
t1.insert(6666)
t1.insert(0)
t1.pretty_print


