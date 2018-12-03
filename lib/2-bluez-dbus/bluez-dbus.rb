# frozen_string_literal: true

dbus_root = '2-bluez-dbus'

require "#{dbus_root}/base/defaults"

require "#{dbus_root}/base/interface_constants"
require "#{dbus_root}/base/signal_constants"
require "#{dbus_root}/base/object_constants"
require "#{dbus_root}/base/object_helpers"

require "#{dbus_root}/base/chain_errors"
require "#{dbus_root}/base/signal_delegate"
require "#{dbus_root}/base/signal_delegator"

# INTERFACES ----------------------------------------------------

root =  "#{dbus_root}/interfaces"

# Mixins to allow arbitrary delegate handler classes
require "#{root}/object_manager/object_manager_handler"
require "#{root}/properties/properties_handler"

# Base class for all Objet Listeners
require "#{root}/object_manager/object_manager_listener"
require "#{root}/properties/properties_listener"
require "#{root}/base/base_signal_listener"

# INTERFACES ----------------------------------------------------

# Call Event
require "#{root}/base/callable"

# Signal Classes
require "#{root}/base/base_signal"
require "#{root}/object_manager/signals/interfaces_added"
require "#{root}/object_manager/signals/interfaces_removed"
require "#{root}/properties/signals/properties_changed"

# Mixins to provide signal subscription interfaces
require "#{root}/object_manager/object_manager_signals"
require "#{root}/properties/properties_signals"

# D-Bus Interfaces
require "#{root}/object_manager/object_manager"
require "#{root}/properties/properties"

require "#{root}/adapter/bluez_adapter"
require "#{root}/agent_manager/bluez_agent_manager"
require "#{root}/device/device_interface_handler"
require "#{root}/device/bluez_device"
require "#{root}/gatt_manager/bluez_gatt_manager"
require "#{root}/health_manager/bluez_health_manager"
require "#{root}/media/bluez_media"
require "#{root}/media_control/media_control_interface_handler"
require "#{root}/media_control/bluez_media_control"
require "#{root}/media_folder/bluez_media_folder"
require "#{root}/media_item/bluez_media_item"
require "#{root}/media_player/media_player_interface_handler"
require "#{root}/media_player/bluez_media_player"
require "#{root}/media_transport/bluez_media_transport"
require "#{root}/network/bluez_network"
require "#{root}/network_server/bluez_network_server"
require "#{root}/profile_manager/bluez_profile_manager"

# OBJECTS ----------------------------------------------------------->

root =  "#{dbus_root}/objects"

require "#{root}/device/signals/device_properties_changed"
require "#{root}/device/bluez_device_object"
require "#{root}/device/bluez_device_listener"

require "#{root}/controller/bluez_controller_object"
require "#{root}/controller/bluez_controller_listener"

require "#{root}/core/bluez_core_object"

require "#{root}/player/signals/player_properties_changed"
require "#{root}/player/bluez_player_listener"

require "#{root}/browser/bluez_browser_object"
require "#{root}/player/bluez_player_object"
require "#{root}/media_transport/bluez_media_transport_object"

require "#{root}/root/handlers/player_object_handler"
require "#{root}/root/handlers/browser_object_handler"
require "#{root}/root/handlers/transport_object_handler"
require "#{root}/root/bluez_root_object"
require "#{root}/root/bluez_root_listener"

# SERVICE ------------------------------------------------------------

root =  "#{dbus_root}/service"

require "#{root}/bluez_service"
require "#{root}/bluez_service_listener"

# CONTAINER ------------------------------------------------------------

require "#{dbus_root}/bluez_dbus"
