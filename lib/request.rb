module Kivi
  class Request
    def initialize(hash = {})
      hash[:params] ||= {}
      hash[:params]['args'] = hash[:args] if hash[:args]
      set_method      hash[:method]   || 'POST'
      set_params      hash[:params]
      set_path        hash[:path]     || '/'
    end
    def params
      @params
    end
    def args
      @params['args'] || []
    end
    def path
      @path
    end
    def extension
      @extension
    end
    protected
    def set_method(m)
      @method  = m.downcase
    end
    def set_params(p)
      @params  = p
    end
    def set_path(path)
      path = path =~ /\/$/ ? path[1..-2] : path[1..-1] # obcięcie ostatniego slesza
      if position = path =~ /.\w+$/
        @path = path[0..position-1]
        @extension = path[position+1..-1]
      else
        @path = path
        @extension = nil
      end
    end
  end
end
