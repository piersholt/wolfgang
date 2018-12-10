# frozen_string_literal: true

car_kit_root = '6-virtual-car-kit'
controller_root = car_kit_root + '/controller'
manager_root = car_kit_root + '/manager'

# Controller
require "#{controller_root}/notifications/player_notification_handler"
require "#{controller_root}/notifications/target_notification_handler"
require "#{controller_root}/notifications/notification_listener"

require "#{controller_root}/commands/command_listener"
require "#{controller_root}/commands/command_handler"

require "#{controller_root}/controller"

# Manager
require "#{manager_root}/notifications/manager_notification_handler"

# Cat Kit
require "#{car_kit_root}/virtual_car_kit"
