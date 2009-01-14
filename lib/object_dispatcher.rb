require 'lib/dispatcher'
module Kivi
  class ObjectDispatcher < Kivi::Dispatcher
    def initialize
      add_controller do |request|
        return nil unless request.path =~ /^[a-z]\w*$/
        method = request.path
        @application.respond_to?(method) ? @application.send(method) : Kivi::NoMethodError
      rescue
        
      end
    end
    def application(app)
      @application = app
    end
  end
end