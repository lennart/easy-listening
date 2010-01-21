describe "A HelloWorld object" do
  before do
    recreate_db
    @hello = HelloWorld.new :message => "Hello World"
  end

  it "should save" do
    @hello.save.should be_true
  end

  it "should be possible to fetch created HelloWorlds" do
    @hello.save
    HelloWorld.first.should_not be_nil
  end
end
