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
  p html
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
2. /\sclass*?\W/ matches class
3. /\s*(\w*?)\s*=/i    generic match for class, id, name ...
4. (?<=(\"|\')).*?(?=(\"|\'))   look ahead and back to avoid quotes, but takes everything between quotes
5.
Donald Kelsey	6:42 PM
<[^<>]*>[^<>]*<\/[^<>]*>

=end