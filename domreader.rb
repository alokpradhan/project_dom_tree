class DomReader

	def readfile
		text = []
		file_lines = File.readlines("test.html")
	 	file_lines.each do |lines|
	 		text << parse_tag(lines)
	 	end
 		p text
 		#text.each {|line| puts text}
 	end

	def parse_tag(tag)
		regex = /<(.*?)>/					#matches entrire string within <>
		whole_line = tag.scan(regex)
		whole_line = whole_line.join
		html = Hash.new
		  #words = whole_line.each.scan(/\w+.*?/)
		tag = []
		portions = (/^\s*([a-z]*)(.*)/i).match(whole_line)
		html[:tag_name] = portions[1]
		p portions[2]
		hash_keys = portions[2].scan(/\s*(\w*?)\s*=/i)
		vals = portions[2].scan(/((\'|\").*?(\'|\"))/)

		hash_keys.each_with_index do |key, i|
		  	html[key.join.to_sym] = vals[i][0].split
		end
		html
	end

	def parse_text(line)
		unless line.include?("<")
			text_in_line = line
		else
			regex = /(?<=\>).*(?=(\<))/  #checks on a line between >  and <
			text_in_line = line.match(regex)
			text_in_line = text_in_line[0]
		end
		text_in_line
	end
end

	# - name
	# - text
	# - classes
	# - id
	# - children
	# - parent

	# line has an opening tag, or closing tag, or text, or mixing all
	# tell if a line is an opening tag or closing ^<head
	# we need ID's and classes to check if it unique
