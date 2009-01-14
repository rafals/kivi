require 'lib/model_controller'
require 'lib/errors'
module Kivi
  class ApplicationController < Kivi::ModelController
    def application
      models['application']
    end
    def call(request)
      if request.path =~ /^[a-z]\w*/
        if application
          return object_method(application.new, request.path).call(*request.args)
        else
          raise Kivi::NoApplicationError
        end
      else
        return result = super(request) ? result : nil
      end
    rescue Kivi::Error => error
      
    end
  end
end