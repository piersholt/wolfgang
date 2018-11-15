# frozen_string_literal: true

require 'bluez-dbus/base/constants'
require 'bluez-dbus/base/bluez_defaults.rb'
require 'bluez-dbus/base/bluez_base_listener.rb'
require 'bluez-dbus/base/bluez_base_handler.rb'

# OBJECTS ----------------------------------------------------------->

# CORE
require 'bluez-dbus/core/bluez_agent_manager.rb'
require 'bluez-dbus/core/bluez_health_manager.rb'
require 'bluez-dbus/core/bluez_profile_manager.rb'
require 'bluez-dbus/core/bluez_core_object.rb'

# CONTROLLER/ADAPTER
require 'bluez-dbus/controller/bluez_adapter.rb'
require 'bluez-dbus/controller/bluez_gatt_manager.rb'
require 'bluez-dbus/controller/bluez_media.rb'
require 'bluez-dbus/controller/bluez_network_server.rb'
require 'bluez-dbus/controller/bluez_controller_object.rb'
require 'bluez-dbus/controller/bluez_controller_listener.rb'
require 'bluez-dbus/controller/bluez_adapter_handler.rb'

# DEVICE
require 'bluez-dbus/device/bluez_device.rb'
require 'bluez-dbus/device/bluez_media_control.rb'
require 'bluez-dbus/device/bluez_network.rb'
require 'bluez-dbus/device/bluez_device_object.rb'
require 'bluez-dbus/device/bluez_device_listener.rb'
require 'bluez-dbus/device/bluez_device_handler.rb'
require 'bluez-dbus/device/bluez_media_control_handler.rb'

# PLAYER
require 'bluez-dbus/player/bluez_media_player.rb'
require 'bluez-dbus/player/bluez_player_object.rb'
require 'bluez-dbus/player/bluez_player_listener.rb'
require 'bluez-dbus/player/bluez_media_player_handler.rb'

# MEDIA TRANSPORT
require 'bluez-dbus/media_transport/bluez_media_transport.rb'
require 'bluez-dbus/media_transport/bluez_media_transport_object.rb'

# SERVICE ------------------------------------------------------------

require 'bluez-dbus/service/bluez_root_object.rb'
require 'bluez-dbus/service/bluez_service.rb'

