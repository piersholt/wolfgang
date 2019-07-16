# frozen_string_literal: true

puts 'wolfgang/bluez_dbus'

module Wolfgang
  # Hashify
  module Hashify
    extend self

    def symbolize(hash)
      symbolized_hash = {}
      hash.each do |key, value|
        case value.is_a?(Hash)
        when true
          symbolized_hash[key.to_sym.downcase] = symbolize(value)
        when false
          symbolized_hash[key.to_sym.downcase] = value
        end
      end
      symbolized_hash
    end

    def symbolize_array(array)
      array.map { |o| o.to_sym.downcase }
    end
  end
end

# Standard Interfaces
LogActually.is_all_around(:interface_object_manager)
LogActually.interface_object_manager.i
LogActually.is_all_around(:interface_properties)
LogActually.interface_properties.i

# Bluez Interraces
LogActually.is_all_around(:interface_media_transport)
LogActually.interface_media_transport.i
LogActually.is_all_around(:interface_media_control)
LogActually.interface_media_control.d
LogActually.is_all_around(:interface_media_player)
LogActually.interface_media_player.d
LogActually.is_all_around(:interface_media_browser)
LogActually.interface_media_browser.i

# Standard Objects
LogActually.is_all_around(:object_root)
LogActually.object_root.d

# Bluez Objects
LogActually.is_all_around(:object_media_transport)
LogActually.object_media_transport.i
LogActually.is_all_around(:object_media_browser)
LogActually.object_media_browser.i
LogActually.is_all_around(:object_controller)
LogActually.object_controller.i
LogActually.is_all_around(:object_device)
LogActually.object_device.d
LogActually.is_all_around(:object_player)
LogActually.object_player.d

# Bluez
LogActually.is_all_around(:service_bluez)
LogActually.service_bluez.i

require_relative '2-bluez-dbus/base'
require_relative '2-bluez-dbus/interfaces'
require_relative '2-bluez-dbus/objects'
require_relative '2-bluez-dbus/service'
require_relative '2-bluez-dbus/bluez_dbus'
