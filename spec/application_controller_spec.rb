require 'lib/application_controller'
require 'lib/request'

describe Kivi::ApplicationController do
  before :all do
    class Application
      def heja
        :heja
      end
    end
    @controller = Kivi::ApplicationController.new do |c|
      c.add_model Application 
    end
  end
  it "should respond to app methods without arguments" do
    request = Kivi::Request.new(:path => '/heja/')
    @controller.call(request).should == :heja
  end
end
