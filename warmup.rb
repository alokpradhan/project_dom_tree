def parse_tag(tag)

  regex = /<(.*?)>/
  tags = tag.scan(regex)

end