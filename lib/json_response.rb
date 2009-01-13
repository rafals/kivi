require 'lib/response'
module Kivi
  class JSONResponse < Kivi::Response
    def initialize(content, params = {})
      params[:status] ||= 200
      super(JSON.dump(content), :type => 'text/json', :status => params[:status])
    end
  end
end