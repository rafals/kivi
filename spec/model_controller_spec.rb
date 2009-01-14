require 'lib/model_controller'
require 'lib/request'

describe Kivi::ModelController do
  before(:all) do
    class Model
      def self.get(id)
        return self.new
      end
      def hello
        "hello controller"
      end
      def increment(a)
        a + 1
      end
    end
    @controller = Kivi::ModelController.new do |c|
      c.add_model Model
    end
  end
  it "should have attached controllers" do
     @controller.models['model'].should == Model
  end
  it "should getting model" do
    @controller.get_model('model').should == Model
  end
  it "should getting object" do
    @controller.get_object('model', 1).class.to_s.should == 'Model'
  end
  it "should getting method" do
    empty_array = []
    @controller.get_object('model', 1).method('hello').call(*[]).should == 'hello controller'
  end
  it "should handle model method without arguments" do
    request = Kivi::Request.new(:path => '/model/1/hello/')
    @controller.call(request).should == Model.get(1).hello
  end
  it "should handle model method with simple argument" do
    request = Kivi::Request.new(:path => '/model/1/increment', :args => 5)
    @controller.call(request).should == 6
  end
end
