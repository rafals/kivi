require 'lib/errors'
module Kivi
  class Controller
    def initialize
      yield self if block_given?
    end
    def controllers
      @controllers ||= []
    end
    def add_controller(*args, &block)
      controllers << block
    end
    def delegate
      controllers.each do |controller|
        if response = controller.call(request)
          return response
        end
      end
    end
    def call(request)
      delegate(request)
    end
  end
end