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
		@output = []
		read_tree(@tree.root, "")
	end

	def write_file
		puts "write file"
		File.open("output.html", "w") do |file|
			@output.each do |line|
				puts line
				file.write line+"\n"
			end
		end
	end

	private

	def read_tree(n, indent)
		return if n.nil?
		@output << (indent + combine_line(n))
		@output << (indent + "  " + "#{n.text}") if n.text != ""
		n.children.each do |child|
			print(child, indent+"  ")
		end
		@output << (indent + "</#{n.name}>")
	end

	def combine_line(node)
		output = "<"
		output += "#{node.name}" if node.name
		output += " id = \"#{node.name}\"" if node.id
		output += " class = \"#{node.classes}\"" if node.classes
		output += ">"
	end
		
	# Iterative method
	# def read_tree
	# 	stack = [[@tree.root, 0]]
	# 	render_io = []
	# 	until stack.empty?
	# 		n, depth = stack.pop
	# 		render_io << combine_line(n)
	# 		render_io << "#{n.text}" if n.text != ""			
	# 		if (n.children.empty? && !stack.empty?)
	# 			cur = n
	# 			(depth - stack[-1][1] + 1).times do
	# 				render_io << "</#{cur.name}>"
	# 				cur = cur.parent
	# 			end
	# 		end
	# 		if (n.children.empty? && stack.empty?)
	# 			cur = n
	# 			while cur
	# 			 	render_io << "</#{cur.name}>"
	# 				cur = cur.parent
	# 		 	end
	# 		end
	# 		n.children.reverse.each {|child| stack << [child, depth+1]}
	# 	render_io
	# end

end