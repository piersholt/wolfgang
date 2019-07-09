# frozen_string_literal: true

puts 'wolfgang/bluez_dbus/interfaces'

# D-BUS INTERFACES

# Mixins to allow arbitrary delegate handler classes
require_relative 'interfaces/object_manager/object_manager_handler'
require_relative 'interfaces/properties/properties_handler'

# Base class for all Objet Listeners
require_relative 'interfaces/object_manager/object_manager_listener'
require_relative 'interfaces/properties/properties_listener'
require_relative 'interfaces/base/base_signal_listener'

# BLUEZ INTERFACES

# Call Event
require_relative 'interfaces/base/callable'

# Signal Classes
require_relative 'interfaces/base/base_signal'
require_relative 'interfaces/object_manager/signals/interfaces_added'
require_relative 'interfaces/object_manager/signals/interfaces_removed'
require_relative 'interfaces/properties/signals/properties_changed'

# Mixins to provide signal subscription interfaces
require_relative 'interfaces/object_manager/signals'
require_relative 'interfaces/properties/signals'

# D-Bus Standard Interfaces
require_relative 'interfaces/object_manager/methods'
require_relative 'interfaces/object_manager/object_manager'
require_relative 'interfaces/properties/methods'
require_relative 'interfaces/properties/properties'

# Bluez Interfaces
require_relative 'interfaces/adapter/bluez_adapter'
require_relative 'interfaces/agent_manager/bluez_agent_manager'
require_relative 'interfaces/device/device_interface_handler'
require_relative 'interfaces/device/constants'
require_relative 'interfaces/device/properties'
require_relative 'interfaces/device/methods'
require_relative 'interfaces/device/bluez_device'
require_relative 'interfaces/gatt_manager/bluez_gatt_manager'
require_relative 'interfaces/health_manager/bluez_health_manager'
require_relative 'interfaces/media/bluez_media'
require_relative 'interfaces/media_control/media_control_interface_handler'
require_relative 'interfaces/media_control/bluez_media_control'
require_relative 'interfaces/media_folder/bluez_media_folder'
require_relative 'interfaces/media_item/bluez_media_item'
require_relative 'interfaces/media_player/media_player_interface_handler'
require_relative 'interfaces/media_player/methods'
require_relative 'interfaces/media_player/constants'
require_relative 'interfaces/media_player/properties'
require_relative 'interfaces/media_player/bluez_media_player'
require_relative 'interfaces/media_transport/bluez_media_transport'
require_relative 'interfaces/network/bluez_network'
require_relative 'interfaces/network_server/bluez_network_server'
require_relative 'interfaces/profile_manager/bluez_profile_manager'
