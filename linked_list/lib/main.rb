# frozen_string_literal: true

require_relative 'linked_list'

l1 = LinkedList.new
l1.append(10)
l1.append(20)
l1.prepend(30)
l1.append(40)
l1.to_s
l1.count
l1.tail
l1.head
l1.at(1)
l1.at(3)

l1.pop
l1.contains?(20)

l2 = LinkedList.new
l2.pop
l2.count
l2.contains?(1)
l2.append(0)
l2.pop
l2
l2.find(50)
l1.find(30)
l1.find(40)
l1.find(20)
l1.to_s
p "l1.head: #{l1.head.data} l1.tail: #{l1.tail.data}"
l1.insert_at(2, 2)
p "l1.head: #{l1.head.data} l1.tail: #{l1.tail.data}"
l1.insert_at(2, 4)
l1.to_s
p "l1.head: #{l1.head.data} l1.tail: #{l1.tail.data}"
l1.to_s
l1.remove_at(4)
l1.remove_at(0)
l1.to_s
p "l1.head: #{l1.head.data} l1.tail: #{l1.tail.data}"
