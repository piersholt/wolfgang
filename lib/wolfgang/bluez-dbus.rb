# frozen_string_literal: true

puts 'wolfgang/bluez_dbus'


# Core Objects
LogActually.is_all_around(:interface_object_manager)
LogActually.interface_object_manager.i
LogActually.is_all_around(:interface_properties)
LogActually.interface_properties.i

# Interfaces
LogActually.is_all_around(:interface_media_transport)
LogActually.interface_media_transport.i
LogActually.is_all_around(:interface_media_control)
LogActually.interface_media_control.d
LogActually.is_all_around(:interface_media_player)
LogActually.interface_media_player.d
LogActually.is_all_around(:interface_media_browser)
LogActually.interface_media_browser.i

# Objects
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
LogActually.is_all_around(:object_root)
LogActually.object_root.d

# Bluez
LogActually.is_all_around(:service_bluez)
LogActually.service_bluez.i

require_relative '2-bluez-dbus/base'
require_relative '2-bluez-dbus/interfaces'
require_relative '2-bluez-dbus/objects'
require_relative '2-bluez-dbus/service'
require_relative '2-bluez-dbus/bluez_dbus'
