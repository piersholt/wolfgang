# frozen_string_literal: true

puts "\tLoading wolfgang/bluez_dbus/objects"

require_relative 'objects/device/signals/device_properties_changed'
require_relative 'objects/device/bluez_device_object'
require_relative 'objects/device/bluez_device_listener'

require_relative 'objects/controller/bluez_controller_object'
require_relative 'objects/controller/bluez_controller_listener'

require_relative 'objects/core/bluez_core_object'

require_relative 'objects/player/signals/player_properties_changed'
require_relative 'objects/player/bluez_player_listener'

require_relative 'objects/browser/bluez_browser_object'
require_relative 'objects/player/bluez_player_object'
require_relative 'objects/media_transport/bluez_media_transport_object'

require_relative 'objects/root/handlers/player_object_handler'
require_relative 'objects/root/handlers/browser_object_handler'
require_relative 'objects/root/handlers/transport_object_handler'
require_relative 'objects/root/bluez_root_object'
require_relative 'objects/root/bluez_root_listener'
