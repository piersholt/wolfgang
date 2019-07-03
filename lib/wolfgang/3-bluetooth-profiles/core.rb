# frozen_string_literal: true

puts 'wolfgang/bluetooth_profiles/core'

# MANAGER
require_relative 'core/manager/signal_handling'
require_relative 'core/manager/notifications'
require_relative 'core/manager/manager'

# DEVICE
require_relative 'core/device/attributes'
require_relative 'core/device/state'
require_relative 'core/device/device'

require_relative 'core/manager_role'
