# frozen_string_literal: true

require 'pry'
class Tree
  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(sorted_array, start = 0, last = sorted_array.length - 1)
    return nil if start > last

    middle = (start + last) / 2
    root = Node.new(sorted_array[middle])
    root.left = build_tree(sorted_array, start, middle - 1)
    root.right = build_tree(sorted_array, middle + 1, last)
    root
  end

  def insert(val, root = @root)
    return Node.new(val) if root.nil?

    val > root.data ? root.right = insert(val, root.right) : root.left = insert(val, root.left)
    root
  end

  def delete(val, parent = nil, root = @root, is_left_child = false)
    return if root.nil?

    if root.data == val
      if root.left.nil? && root.right.nil?
        is_left_child ? parent.left = nil : parent.right = nil
      elsif root.left && !root.right
        is_left_child ? parent.left = root.left : parent.right = root.left
      elsif root.right && !root.left
        is_left_child ? parent.left = root.right : parent.right = root.right
      else
        root.data = delete_helper(root.right, root, val)
      end
      return root.data
    end
    val > root.data ? delete(val, root, root.right, false) : delete(val, root, root.left, true)
  end

  def delete_helper(root, parent, val)
    if root.left.nil?
      if parent.data != val
        parent.left = (root.right || nil)
      else
        parent.right = root.right
      end
      return root.data
    end
    delete_helper(root.left, root, val) if root.left
  end

  def inorder(root = @root, arr = [], &block)
    return if root.nil?

    inorder(root.left, arr, &block)
    block_given? ? (yield root) : arr.push(root.data)
    inorder(root.right, arr, &block)
    return arr unless block_given?
  end

  def preorder(root = @root, arr = [], &block)
    return if root.nil?

    block_given? ? (yield root) : arr.push(root.data)
    preorder(root.left, arr, &block)
    preorder(root.right, arr, &block)
    return arr unless block_given?
  end

  def postorder(root = @root, arr = [], &block)
    return if root.nil?

    postorder(root.left, arr, &block)
    postorder(root.right, arr, &block)
    block_given? ? (yield root) : arr.push(root.data)
    return arr unless block_given?
  end

  def level_order(queue = [@root], arr = [], &block)
    return if queue.empty?

    block_given? ? (yield queue[0]) : arr.push(queue[0].data)
    queue.push(queue[0].left) if queue[0].left
    queue.push(queue[0].right) if queue[0].right
    queue.shift
    level_order(queue, arr, &block)
    return arr unless block_given?
  end

  def find(value, root = @root)
    return root if root.nil? || root.data == value

    value > root.data ? find(value, root.right) : find(value, root.left)
  end

  def height(root, level = -1, count = -1)
    return count if root.nil?

    level += 1
    count = level if level > count
    count = height(root.left, level, count)
    count = height(root.right, level, count)
    level -= 1
    count
  end

  def depth(node)
    height(@root) - height(node)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def balanced?
    (height(@root.left) - height(@root.right)).abs <= 1
  end

  def rebalance
    @root = build_tree(level_order.uniq.sort) unless balanced?
  end
end

class Node
  attr_accessor :left, :right, :data

  def initialize(data = nil)
    @left = @right = nil
    @data = data
  end
end

t = Tree.new(Array.new(15) { rand(1..100) })
t.balanced?
t.pretty_print
t.inorder { |node| print "#{node.data} -> " }
t.preorder { |node| print "#{node.data} -> " }
t.postorder { |node| print "#{node.data} -> " }

150.times { t.insert(rand(1..100)) }
t.pretty_print
t.balanced?
t.rebalance
t.pretty_print
t.balanced?
100.times { t.delete(rand(1..100)) }
t.pretty_print
t.balanced?
t.rebalance
t.pretty_print

t.inorder { |node| print "#{node.data} -> " }
t.preorder { |node| print "#{node.data} -> " }
t.postorder { |node| print "#{node.data} -> " }
