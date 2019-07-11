# frozen_string_literal: true

puts 'wolfgang/virtual_car_kit'

# Car Kit
LogActually.is_all_around(:notifications)
LogActually.notifications.i
LogActually.is_all_around(:commands)
LogActually.commands.i

# Controller
require_relative '6-virtual-car-kit/controller/notifications/player_notification_handler'
require_relative '6-virtual-car-kit/controller/notifications/target_notification_handler'
require_relative '6-virtual-car-kit/controller/commands/media_handler'
require_relative '6-virtual-car-kit/controller/commands/target_handler'
require_relative '6-virtual-car-kit/controller/controller'

# Manager
require_relative '6-virtual-car-kit/manager/notifications/manager_notification_handler'
require_relative '6-virtual-car-kit/manager/commands/device_handler'
require_relative '6-virtual-car-kit/manager/manager'

# Cat Kit
require_relative '6-virtual-car-kit/notifications/notification_listener'
require_relative '6-virtual-car-kit/commands/wilhelm_handler'
require_relative '6-virtual-car-kit/commands/command_listener'
require_relative '6-virtual-car-kit/virtual_car_kit'
