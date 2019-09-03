describe "Block class" do
  it "get initialized as a type of Block" do
    block = Hotel::Block.new
    expect block.must_be_kind_of Hotel::Block
  end
end
