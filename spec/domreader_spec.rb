require 'domreader'

describe DomReader do

  let(:a) {DomReader.new}
  before do
    a.readfile
    a.create_nodes
  end

  it "should have domtree" do

    puts a.tree.root
  end

end
