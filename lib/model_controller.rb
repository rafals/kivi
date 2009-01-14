require 'lib/errors'
module Kivi
  class ModelController
    def initialize
      yield self if block_given?
    end
    def models
      @models ||= {}
    end
    def class_name(klass)
      klass.allocate.class.to_s.downcase
    end
    def add_model(klass, params = {})
      params[:as] ||= class_name(klass)
      models[params[:as]] = klass
    end
    def call(request)
      if request.path =~ /^[a-z]\w*\/\d+\/[a-z]\w*$/
        model_name, id, method_name = request.path.split('/')
        obj = get_object(model_name, id)
        method = object_method(obj, method_name)
        return method.call(*request.args)
      else
        nil
      end
    end
    def get_instance(model, id)
      model.get(id)
    end
    def get_object(model_name, id)
      model = get_model(model_name)
      get_instance(model, id) or raise Kivi::ModelIDError
    rescue Kivi::ModelIDError
      raise Kivi::ModelIDError
    end
    def get_model(name)
      if models[name]
        models[name]
      else
        raise Kivi::ModelNameError
      end
    end
    def object_method(obj, method_name)
      if obj.respond_to?(method_name)
        return obj.method(method_name)
      else
        raise Kivi::MethodNameError
      end
    end
  end
end