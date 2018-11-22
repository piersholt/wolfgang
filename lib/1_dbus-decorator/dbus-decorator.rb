# frozen_string_literal: true

require 'dbus'

dbus_decorator_root = '1_dbus-decorator'

require "#{dbus_decorator_root}/base/dbus_constants"

require "#{dbus_decorator_root}/object/object_adapter.rb"
require "#{dbus_decorator_root}/object/proxy_object_factory_adapter.rb"

require "#{dbus_decorator_root}/interface/interface_adapter.rb"

require "#{dbus_decorator_root}/service/service_adapter.rb"

require "#{dbus_decorator_root}/bus/bus_adapter.rb"
