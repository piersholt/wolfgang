# frozen_string_literal: true

puts 'Loading wolfgang/dbus_adapter'

require_relative '1-dbus-adapter/object_adapter'
require_relative '1-dbus-adapter/proxy_object_factory_adapter'
require_relative '1-dbus-adapter/interface_adapter'
require_relative '1-dbus-adapter/service_adapter'
require_relative '1-dbus-adapter/bus_adapter'

puts "\tDone!"
