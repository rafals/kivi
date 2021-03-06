require 'lib/errors'
require 'lib/json_response'
module Kivi
  class Dispatcher
    def initialize
      yield self if block_given?
    end
    def controllers
      @controllers ||= []
    end
    def add_controller(*args, &block)
      controllers << block
    end
    def dispatch(request)
      controllers.each do |controller|
        begin
          if response = controller.call(request)
            return response
          else
            nil
          end
        end
      end
      raise Kivi::UnhandledRequestError
    end
  end
end