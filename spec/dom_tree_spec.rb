require 'dom_tree'

describe DomTree do

  let(:dt) { DomTree.new("html") }
  let(:stack) {dt.instance_variable_get(:@stack)}

  describe "#initialize" do
    
    it "should create DomTree object" do
      expect(dt).to be_a(DomTree)
    end

  end

  describe "#opening_tag" do

    it "should insert a new node to its parent" do
      dt.opening_tag("head", "we are something before head")
      expect(stack[-2].name).to eq("html")
      expect(stack[-2].text).to eq("we are something before head")
      expect(stack[-1].name).to eq("head")
      expect(stack[-1].text).to eq("")
    end

  end


  describe "#closing_tag" do
    

    it "should return to its parent" do
      dt.opening_tag("head", "we are something before head")
      dt.closing_tag("head", "we are in head now")
      expect(stack[-1].name).to eq("html")
      expect(stack[-1].text).to eq("we are something before head")

      expect(stack[-1].children[0].name).to eq("head")
      expect(stack[-1].children[0].text).to eq("we are in head now")
    end

  end

end
