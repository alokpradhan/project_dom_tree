Node = Struct.new(:name, :text, :classes, :id, :children, :parent)

class DomTree

  attr_reader :root

  def initialize(name)
    @root = new_node(name)
    @stack = [@root]
  end

  def opening_tag(name, text)
    child = new_node(name)
    child.parent = stack[-1]
    stack[-1].children << child
    stack[-1].text += text
    stack << child
  end

  def closing_tag(name, text)
    stack.pop.text += text
  end

  private

  def new_node(name)
    Node.new(name, "", [], "", [], nil)
  end

  def stack
    @stack
  end
end