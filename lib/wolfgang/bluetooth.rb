# frozen_string_literal: true

puts 'wolfgang/bluetooth'

LogActually.is_all_around(:bt_device)
LogActually.bt_device.d

require_relative '3-bluetooth/device'
require_relative '3-bluetooth/profile'
