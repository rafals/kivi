module Kivi
  class Response
    def initialize(body, params = {})
      @body, @type, @status = body, params[:type], params[:status]
    end
    attr_accessor :body, :type, :status
  end
end
