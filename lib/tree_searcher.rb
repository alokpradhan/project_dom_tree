class TreeSearcher

  def initialize(tree)
    @tree = tree
  end

  def search_by(attribute, keyword)
    bfs(tree.root, attribute, keyword)
  end

  def search_children(node, attribute, keyword)
    bfs(node, attribute, keyword)
  end

  def search_ancestors(node, attribute, keyword)
    search_result = []
    until node.parent
       search_result << node.parent if is_match?(node, attribute, keyword)
       node = node.parent
    end
    search_result
  end

  private

  def tree
    @tree
  end

  def bfs(node, attribute, keyword)
    queue = [node]
    search_result = []
    until queue.empty?
      n = queue.shift
      search_result << n if is_match?(n, attribute, keyword)
      n.children.each {|c| queue << c}
    end
    search_result
  end

  def is_match?(node, attribute, keyword)
    if attribute == :classes
      return node[attribute].include?(keyword)
    else
      return node[attribute] == keyword
    end
  end

end