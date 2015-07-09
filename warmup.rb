def parse_tag(tag)

  regex = /<(.*?)>/					#matches entrire string within <>
  whole_line = tag.scan(regex)
  html = Hash.new
  #words = whole_line.each.scan(/\w+.*?/)
  tag = []
  whole_line.each do |section|
  	tag << (/\w+.*?/).match(section)
  end
  p whole_line
  p words
end


=begin
1. Get the whole string
2. Split tags

Regex needed
1. capture tags
2. capture words after outside quotes
3. capture words between quotes
4. capture words between > <

Regex tried:

1. /\w+.*?/   matches all words in a string


=end