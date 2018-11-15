# All bluez-dbus requirements

# frozen_string_literal: true

# Inteface name constants
require 'bluez-dbus/interfaces/constants'

# /org/bluez
require 'bluez-dbus/interfaces/bluez_agent_manager.rb'
require 'bluez-dbus/interfaces/bluez_health_manager.rb'
require 'bluez-dbus/interfaces/bluez_profile_manager.rb'

# /org/bluez/hci{x}
require 'bluez-dbus/interfaces/bluez_adapter.rb'
require 'bluez-dbus/interfaces/bluez_gatt_manager.rb'
require 'bluez-dbus/interfaces/bluez_media.rb'
require 'bluez-dbus/interfaces/bluez_network_server.rb'

# /org/bluez/dev_{xx:xx:xx:xx:xx:xx}
require 'bluez-dbus/interfaces/bluez_device.rb'
require 'bluez-dbus/interfaces/bluez_media_control.rb'
require 'bluez-dbus/interfaces/bluez_network.rb'

# /org/bluez/{device}/fd{x}
require 'bluez-dbus/interfaces/bluez_media_transport.rb'

# /org/bluez/{device}/player{x}
require 'bluez-dbus/interfaces/bluez_media_player.rb'

require 'bluez-dbus/objects/bluez_player_object.rb'
require 'bluez-dbus/objects/bluez_media_transport_object.rb'
require 'bluez-dbus/objects/bluez_device_object.rb'
require 'bluez-dbus/objects/bluez_controller_object.rb'
require 'bluez-dbus/objects/bluez_core_object.rb'
require 'bluez-dbus/objects/bluez_root_object.rb'

require 'bluez-dbus/listeners/bluez_base_listener.rb'
require 'bluez-dbus/handlers/bluez_base_handler.rb'

# /org/bluez/hci{x}
require 'bluez-dbus/listeners/bluez_controller_listener.rb'

require 'bluez-dbus/handlers/bluez_adapter_handler.rb'

# /org/bluez/dev_{xx:xx:xx:xx:xx:xx}
require 'bluez-dbus/listeners/bluez_device_listener.rb'

require 'bluez-dbus/handlers/bluez_device_handler.rb'
require 'bluez-dbus/handlers/bluez_media_control_handler.rb'

# /org/bluez/dev_{xx:xx:xx:xx:xx:xx}
require 'bluez-dbus/listeners/bluez_player_listener.rb'

require 'bluez-dbus/handlers/bluez_media_player_handler.rb'

# org.bluez
require 'bluez-dbus/bluez_service.rb'
