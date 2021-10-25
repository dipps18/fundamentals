#Classed and methods

1) class Node: It stores the data as well as left and right children of a tree.

2) Tree class: It accepts an array when initialized. The Tree class has a root attribute which returns the value of #build_tree.

3) #build_tree: It takes an array of data (e.g. [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]) and turns it into a balanced binary tree full of Node objects appropriately placed. The #build_tree method returns the level-0 root node.

4) #insert: method which accepts a value to insert to the tree.

5) #delete:  method which accepts a value to delete from the tree.

6) #find: method which accepts a value and returns the node with the given value.

7) #level_order:  method accepts a block and traverses the tree in breadth-first level order and yield each node to the provided block. The method returns an array of values if no block is given.

8) #inorder, #preorder, and #postorder methods that accepts a block, traverse the tree in their respective depth-first order and yield each node to the provided block. The methods return an array of values if no block is given.

9) #height: method accepts a node and returns its height. Height is defined as the number of edges in longest path from a given node to a leaf node.

10) #depth: method accepts a node and returns its depth. Depth is defined as the number of edges in path from a given node to the tree’s root node.

11) #balanced?: method checks if the tree is balanced. A balanced tree is one where the difference between heights of left subtree and right subtree of every node is not more than 1.

12) #rebalance: method rebalances an unbalanced tree.

