require 'lib/rack_dispatcher'
require 'lib/object_dispatcher'
dispatcher = Kivi::ObjectDispatcher.new
dispatcher.included_modules << Kivi::RackDispatcher
run dispatcher