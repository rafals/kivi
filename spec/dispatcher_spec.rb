require 'lib/dispatcher'
require 'lib/request'
require 'lib/html_response'
describe Kivi::Dispatcher do
  it "should handle one simple controller" do
    data = 'test_arg'
    request = Kivi::Request.new(:args => data)
    controller = Proc.new do |request|
      request.args
    end
    dispatcher = Kivi::Dispatcher.new
    dispatcher.controllers << controller
    dispatcher.dispatch(request).should == data
  end
  it "should handle 2 controllers" do
    data = 'test2_arg'
    request = Kivi::Request.new(:args => data, :path => '/hello/')
    dispatcher = Kivi::Dispatcher.new do |d|
      d.controllers << Proc.new do |request|
        request.path =~ /hejka/ ? true : false
      end
      d.controllers << Proc.new do |request|
        request.path =~ /hello/ ? request.args : nil
      end
    end
    dispatcher.dispatch(request).should == data
  end
end