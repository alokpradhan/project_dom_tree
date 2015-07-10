=begin
	1. dfs for printing
	2. stack for all elements - each branch
	3. stack for closing tags
	3. if there is content, print it
		- classes
		- text
		- id
=end


class Rebuild

	def initialize(tree)
		@tree = tree
	end

	def depth_first_printing
		stack = [[@tree.root, 0]]
		render_io = []
		#closing_tags = [@tree.root.name]
		closing_tags = []
		depth = 0
		until stack.empty?
			n, depth = stack.pop
			render_io << combine_line(n)
			closing_tags << n.name
			render_io << "#{n.text}" if n != ""
			n.children.reverse.each {|child| stack << [child, depth+1]}
			if (n.children.empty? && !stack.empty?)#|| stack[-1][1] != n
				(depth - stack[-1][1] + 1).times do
					render_io << "</#{closing_tags.pop}>"
				end
			end
		end
		# p closing_tags
		# until closing_tags.empty?
		# 	"</#{closing_tags.pop}>"
		# end
		render_io
	end

	def indentation
	end

	def combine_line(node)
		output = "<"
		output += "#{node.name}" if node.name
		output += " id = \"#{node.name}\"" if node.id
		output += " class = \"#{node.classes}\"" if node.classes
		output += ">"
	end

	def print
		depth_first_printing.each {|line| puts line}
	end

end