require 'lib/dispatcher'
require 'lib/request'
require 'rack'
require 'lib/json_response'
require 'lib/html_response'
module Kivi
  class RackDispatcher < Kivi::Dispatcher
    def call(env)
      # składniki zapytania
      method   = env['REQUEST_METHOD']
      params   = Rack::Request.new(env)
      path     = env['REQUEST_PATH']
      # zapytanie                       
      request  = Kivi::Request.new(:method => method, :params => params, :path => path)
      # odpowiedź
      begin
        response = dispatch(request)
      rescue Kivi::NoRouteError
        type = request.extension == 'json' ? Kivi::JSONResponse : Kivi::HTMLResponse
        response = type.new('Controller for this request not found', :status => 404)
      ensure
        [response.status, {"Content-Type" => response.type}, response.body]
      end
    end
  end
end