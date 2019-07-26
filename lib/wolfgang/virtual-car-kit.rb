# frozen_string_literal: true

puts 'Loading wolfgang/virtual_car_kit'

# Car Kit
LogActually.is_all_around(:notifications)
LogActually.notifications.i
LogActually.is_all_around(:commands)
LogActually.commands.d
LogActually.is_all_around(:vcc)
LogActually.vcc.d

# Controller
puts "\tLoading wolfgang/virtual_car_kit/controller"
require_relative 'virtual-car-kit/controller/notifications/player_notification_handler'
require_relative 'virtual-car-kit/controller/notifications/target_notification_handler'
require_relative 'virtual-car-kit/controller/commands/media_handler'
require_relative 'virtual-car-kit/controller/commands/target_handler'
require_relative 'virtual-car-kit/controller/controller'

# Manager
puts "\tLoading wolfgang/virtual_car_kit/manager"
require_relative 'virtual-car-kit/manager/notifications/manager_notification_handler'
require_relative 'virtual-car-kit/manager/commands/device_handler'
require_relative 'virtual-car-kit/manager/manager'

# Cat Kit
puts "\tLoading wolfgang/virtual_car_kit/virtual_car_kit"
require_relative 'virtual-car-kit/notifications/notification_listener'
require_relative 'virtual-car-kit/commands/wilhelm_handler'
require_relative 'virtual-car-kit/commands/command_listener'
require_relative 'virtual-car-kit/virtual_car_kit'

puts "\tDone!"
