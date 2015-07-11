require 'pry'
require_relative './dom_tree.rb'

class DomReader
	attr_reader :tree

	def initialize
		@tree = DomTree.new("doctype")
		readfile
		build_tree
	end

	private

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

	def check_if_both_opening_closing(line)
		!parse_tag_name(line).nil? && !parse_tag_name(line).include?("/") && check_if_closing_tag(line)
	end

	def build_tree
		text_in_line = []
		@text.each do |line|
			tag_name = parse_tag_name(line)
			tag_class = parse_class(line)
			tag_id =  parse_id(line)
			text_in_line << parse_text_in_line(line) || ""
			if check_if_both_opening_closing(line)
				@tree.opening_tag(tag_name, text_in_line[-1], tag_class, tag_id)
				@tree.closing_tag(tag_name, "")
			elsif !tag_name.nil? && !tag_name.include?("/")
				@tree.opening_tag(tag_name, text_in_line[-1], tag_class, tag_id)
			elsif check_if_closing_tag(line)
				@tree.closing_tag(tag_name, text_in_line.pop)
			else
				@tree.insert_text(text_in_line.pop)
			end
		end
	end
end