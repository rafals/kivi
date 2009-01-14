module Kivi
  class Request
    def initialize(hash = {})
      hash[:params] ||= {}
      if hash[:args]
        hash[:params]['args'] = hash[:args]
      end
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
      new_path = path =~ /\/$/ ? path[1..-2] : path[1..-1] # obcięcie ostatniego slesza
      if position = new_path =~ /\.\w+$/
        @path = new_path[0..position-1]
        @extension = new_path[position+1..-1]
      else
        @path = new_path
        @extension = nil
      end
    end
  end
end
