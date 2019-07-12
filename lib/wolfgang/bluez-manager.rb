# frozen_string_literal: true

puts 'wolfgang/bluez_manager'

LogActually.is_all_around(:device)
LogActually.device.d

require_relative '3-bluez-manager/profiles'
require_relative '3-bluez-manager/api'
require_relative '3-bluez-manager/bluez_dbus_interface'
require_relative '3-bluez-manager/bluez_manager'
