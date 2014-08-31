module BinaryTree

class Node
attr_accessor :value, :parent, :left_child, :right_child
	def initialize(value, parent=nil, left_child=nil, right_child = nil)
		@value = value
		@parent = parent
		@left_child = left_child
		@right_child = right_child
	end

	def has_children?
		if @left_child||@right_child
			true
		else
			false
		end
	end

end

class Tree
attr_accessor :root
	def initialize(given_root = nil)
		@root = Node.new(given_root) if given_root
	end

	def self.build_tree(array)
		tree = Tree.new
		array.each do |element|
			tree.add(element)
		tree
		end
	end

	def add(data)
		unless @root
			@root = Node.new(data)
		else
			create_node(data)
		end
	end

	def create_node(data)
		newnode = Node.new(data)


end

end