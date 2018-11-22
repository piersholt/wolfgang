# frozen_string_literal: true

bluez_manager_root = '3_bluez-manager'



require "#{bluez_manager_root}/profiles/profiles"

require "#{bluez_manager_root}/api/bluez_client_api"

# require "#{bluez_manager_root}/listeners/bluez_base_listener"
# require "#{bluez_manager_root}/listeners/bluez_player_listener"
# require "#{bluez_manager_root}/listeners/bluez_device_listener"
# require "#{bluez_manager_root}/listeners/bluez_controller_listener"
# require "#{bluez_manager_root}/listeners/bluez_root_listener"
# require "#{bluez_manager_root}/listeners/bluez_service_listener"

require "#{bluez_manager_root}/bluez_interface"
require "#{bluez_manager_root}/bluez_manager"
