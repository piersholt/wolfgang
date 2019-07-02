# frozen_string_literal: true

LOAD_PATH_LOGGER.debug { 'Loading wolfgang/virtual_car_kit' }

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
