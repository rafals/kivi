require 'lib/response'
module Kivi
  class HTMLResponse < Kivi::Response
    def initialize(content, params = {})
      params[:status] ||= 200
      super(content.to_s, :type => 'text/html', :status => status)
    end
  end
end