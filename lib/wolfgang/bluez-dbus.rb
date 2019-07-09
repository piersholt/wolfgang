# frozen_string_literal: true

puts 'wolfgang/bluez_dbus'

# Bluez
LogActually.is_all_around(:service)
LogActually.service.i

# Core Objects
LogActually.is_all_around(:object_manager)
LogActually.object_manager.i
LogActually.is_all_around(:properties)
LogActually.properties.i

# Objects
LogActually.is_all_around(:controller)
LogActually.controller.i
LogActually.is_all_around(:device)
LogActually.device.i

# Interfaces
LogActually.is_all_around(:media_transport)
LogActually.media_transport.i
LogActually.is_all_around(:media_control)
LogActually.media_control.i
LogActually.is_all_around(:media_player)
LogActually.media_player.i
LogActually.is_all_around(:media_browser)
LogActually.media_browser.i

require_relative '2-bluez-dbus/base'
require_relative '2-bluez-dbus/interfaces'
require_relative '2-bluez-dbus/objects'
require_relative '2-bluez-dbus/service'
require_relative '2-bluez-dbus/bluez_dbus'
