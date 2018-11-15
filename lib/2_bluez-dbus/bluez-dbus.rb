# frozen_string_literal: true

bluez_dbus_root = '2_bluez-dbus'

require "#{bluez_dbus_root}/config/constants"
require "#{bluez_dbus_root}/config/defaults.rb"
require "#{bluez_dbus_root}/config/bluez_base_listener.rb"
require "#{bluez_dbus_root}/config/bluez_base_handler.rb"

# OBJECTS ----------------------------------------------------------->

# ROOT
require "#{bluez_dbus_root}/root/bluez_root_object.rb"

# CORE
require "#{bluez_dbus_root}/core/bluez_agent_manager.rb"
require "#{bluez_dbus_root}/core/bluez_health_manager.rb"
require "#{bluez_dbus_root}/core/bluez_profile_manager.rb"
require "#{bluez_dbus_root}/core/bluez_core_object.rb"

# CONTROLLER/ADAPTER
require "#{bluez_dbus_root}/controller/bluez_adapter.rb"
require "#{bluez_dbus_root}/controller/bluez_gatt_manager.rb"
require "#{bluez_dbus_root}/controller/bluez_media.rb"
require "#{bluez_dbus_root}/controller/bluez_network_server.rb"
require "#{bluez_dbus_root}/controller/bluez_controller_object.rb"
require "#{bluez_dbus_root}/controller/bluez_controller_listener.rb"
require "#{bluez_dbus_root}/controller/bluez_adapter_handler.rb"

# DEVICE
require "#{bluez_dbus_root}/device/bluez_device.rb"
require "#{bluez_dbus_root}/device/bluez_media_control.rb"
require "#{bluez_dbus_root}/device/bluez_network.rb"
require "#{bluez_dbus_root}/device/bluez_device_object.rb"
require "#{bluez_dbus_root}/device/bluez_device_listener.rb"
require "#{bluez_dbus_root}/device/bluez_device_handler.rb"
require "#{bluez_dbus_root}/device/bluez_media_control_handler.rb"

# PLAYER
require "#{bluez_dbus_root}/player/bluez_media_player.rb"
require "#{bluez_dbus_root}/player/bluez_player_object.rb"
require "#{bluez_dbus_root}/player/bluez_player_listener.rb"
require "#{bluez_dbus_root}/player/bluez_media_player_handler.rb"

# MEDIA TRANSPORT
require "#{bluez_dbus_root}/media_transport/bluez_media_transport.rb"
require "#{bluez_dbus_root}/media_transport/bluez_media_transport_object.rb"

# SERVICE ------------------------------------------------------------

require "#{bluez_dbus_root}/service/bluez_service.rb"

require "#{bluez_dbus_root}/bluez_facade.rb"
