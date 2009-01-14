require 'rack'
require 'lib/errors'
require 'lib/request'
require 'lib/json_response'
require 'lib/html_response'
module Kivi
  module RackDispatcher
    def call(env)
      # składniki zapytania
      method   = env['REQUEST_METHOD']
      params   = Rack::Request.new(env)
      path     = env['REQUEST_PATH']
      # zapytanie
      request  = Kivi::Request.new(:method => method, :params => params, :path => path)
      # odpowiedź
      begin
        result = dispatch(request)
      rescue => e
        result = e
      ensure
        response = Kivi::Response.new(result, request)
        [response.status, {"Content-Type" => response.type}, response.body]
      end
    end
  end
end