Node = Struct.new(:name, :text, :classes, :id, :children, :parent)

class DomTree

  attr_reader :root

  def initialize(name="")
    @root = new_node(name)
    @stack = [@root]
  end

  def opening_tag(name, text, tag_class, tag_id)
    child = new_node(name)
    child.parent = stack[-1]
    child.classes = tag_class
    child.id = tag_id
    child.text += text
    stack[-1].children << child
    # stack[-1].text += pre_text
    stack << child
  end

  def closing_tag(name, pre_text)
    stack.pop.text += pre_text
  end

  def insert_text(text)
    stack[-1].text += text
  end

  def check_open_or_close(name, pre_text)
    opening_tag(name,pre_text) || closing_tag(name,pre_text)
  end

  private

  def new_node(name)
    Node.new(name, "", [], "", [], nil)
  end

  def stack
    @stack
  end

end