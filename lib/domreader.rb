require 'pry'
require_relative './dom_tree.rb'

# DomTree = Struct.new(:name,:text,:classes,:children, :parent)

class DomReader
	attr_reader :text, :root, :stack, :tree

	def initialize
		@tree = DomTree.new("root")
		# @stack = [@root]
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
		if !line.include?("<")
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
			tag_name = parse_tag_name(line) || nil
			tag_class = parse_class(line) || nil
			tag_id =  parse_id(line) || nil
			text_in_line << parse_text_in_line(line) || ""
			if !tag_name.nil? && !tag_name.include?("/")
				@tree.opening_tag(tag_name, text_in_line[-1], tag_class, tag_id)
			elsif check_if_closing_tag(line)
				@tree.closing_tag(tag_name, text_in_line.pop)
			else
				@tree.insert_text(text_in_line.pop)
			end
		end
	end
end

a = DomReader.new
a.readfile
a.create_nodes
p a.stack
p @tree