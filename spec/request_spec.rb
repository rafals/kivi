require 'lib/request'
describe Kivi::Request do
  it "should properly prepare path" do
    s = Kivi::Request.new(:path => '/model/1/hello/')
    s.path.should == 'model/1/hello'
  end
  it "should properly explode path to path and extension" do
    r = Kivi::Request.new(:path => '/abc/def.json')
    r.path.should == 'abc/def'
    r.extension.should == 'json'
  end
    
  it "shoud properly handle params and args" do
    r = Kivi::Request.new(:params => {'a' => 1, 'b' => 2}, :args => 'elo')
    r.params.should == {'a' => 1, 'b' => 2, 'args' => 'elo'}
  end
end