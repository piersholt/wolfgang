# frozen_string_literal: true

puts 'Loading wolfgang/dbus_adapter'

require_relative 'dbus-adapter/object_adapter'
require_relative 'dbus-adapter/proxy_object_factory_adapter'
require_relative 'dbus-adapter/interface_adapter'
require_relative 'dbus-adapter/service_adapter'
require_relative 'dbus-adapter/bus_adapter'

puts "\tDone!"
