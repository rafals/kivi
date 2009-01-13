require 'lib/no_controller_error'
module Kivi
  class Dispatcher
    attr_accessor :controllers
    def initialize
      @controllers = []
      yield self if block_given?
    end
    def controller(*args, &block)
      @controllers << block
    end
    def dispatch(request)
      @controllers.each do |controller|
        if response = controller.call(request)
          return response
        end
      end
      raise NoControllerError
    end
  end
end