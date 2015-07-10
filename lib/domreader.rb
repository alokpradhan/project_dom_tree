require 'pry'
require_relative './lib/dom_tree.rb'

# DomTree = Struct.new(:name,:text,:classes,:children, :parent)

class DomReader
	attr_reader :text, :root, :stack, :tree

	def initialize
		@tree = DomTree.new("root")
		@stack = [@root]
	end

	def readfile
		@text = []
		file_lines = File.readlines("test.html")
	 	file_lines.each do |lines|
	 		@text << lines.strip
	 	end
 	end

	def parse_tag_name(line)
		result = line.match(/(?<=\<).*?(?=(\>|\s))/)
		result[0] unless result.nil?
	end

	def parse_class(line)
		result = line.match(/(?<=(class="|class=')).*?(?=(\"|\'))/)
		result[0] unless result.nil?
	end

	def parse_id(line)
		result = line.match(/(?<=(id="|id=')).*?(?=(\"|\'))/)
		result[0] unless result.nil?
	end

	def parse_text_in_line(line)
		unless line.include?("<")
			line
		else
			result = line.match(/(?<=\>).*(?=(\<))/)    #checks on a line between >  and <
			result.nil? ? "" : result[0]
		end
	end

	def check_if_closing_tag(line)
		line.match(/<\//) != nil
	end

	def create_nodes
		text_in_line = []
		@text.each do |line|
		#binding.pry
			tag_name = parse_tag_name(line) || nil
			tag_class = parse_class(line) || nil
			tag_id =  parse_id(line) || nil
			text_in_line << parse_text_in_line(line) || ""
			# create_tree(line, tag_name, tag_class, text_in_line)
			if tag_name != nil
				@tree.opening_tag(tag_name, text_in_line[-1], tag_class, tag_id)
			elsif check_if_closing_tag(line)
				@tree.closing_tag(tag_name, text_in_line.pop)
			end
			# @tree.check_open_or_close(tag_name, text_in_line.pop)
		end
	end

	# def create_tree(line, tag_name, tag_class, text_in_line)
	# 	@tree.check_open_or_close(tag_name, text_in_line.pop)
		# if check_if_closing_tag(line)
		# 	node_to_add = @stack.pop
		# 	# @node_to_add.parent = @tree.last.children
		# 	# @root.children = node_to_add
		# 	# node_to_add.parent = @root
		# 	@tree << node_to_add
		# 	# if @tree.length > 1
		# 	# 	@tree[-2] = node_to_add.parent
		# 	# 	node_to_add = @tree[-2].children
		# 	# end
		# 	# node_to_add.text = text_in_line  #text in line needs to be assigned to prev
		# elsif tag_name == nil
		# 	@stack[-1].text = text_in_line
		# else
		# 	p tag_name
		# 	new_node = DomTree.new(tag_name, nil, tag_class, nil, stack[-1])
	# 	# end
	# end
end

a = DomReader.new
a.readfile
a.create_nodes
# p a.root
# p a.text
p a.stack
p @tree