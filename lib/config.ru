require 'rack_dispatcher'
require 'json_response'
require 'html_response'
dispatcher = Kivi::RackDispatcher.new do |d|
  # sample controllers
  d.controllers << Proc.new do |request|
    return nil unless request.path =~ /^[a-z]\w*\/\d+\/[a-z]\w*$/
    class_name, id, method = request.path.split('/')
    nil # or Kivi::Response instance
  end
  d.controllers << Proc.new do |request|
    nil # ...
  end
end
run dispatcher