# frozen_string_literal: true

puts 'Loading wolfgang/bluetooth_profiles'

# Bluetooth Profiles
LogActually.is_all_around(:core)
LogActually.core.i
LogActually.is_all_around(:avrcp)
LogActually.avrcp.i

require_relative '3-bluetooth-profiles/avrcp'
require_relative '3-bluetooth-profiles/core'
