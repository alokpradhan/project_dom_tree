require_relative './dom_tree.rb'

class NodeRender

	def initialize(tree)
		@tree = tree
	end

	def render(node)
		node ||= @tree.root
		print "Children: "
		node.children.each {|child| print "#{child.name}     "}
		puts "Contents: #{node.text}"
		total_nodes(node)
	end

	def total_nodes(node)
		queue = [node]
		search_result = []
		count_total_nodes = 0
		count_node_type = Hash.new(0)
		until queue.empty?
			n = queue.shift
			search_result << n
			n.children.each {|child| queue << child}
			count_total_nodes += 1
			count_node_type[:"#{n.name}"] += 1
		end
		puts "Node count: #{count_total_nodes}"
		count_node_type.each {|name, occurrences| puts "#{name}: occurs #{occurrences} times"}
	end

	def count_node_type
	end

	def node_data
	end

end