# frozen_string_literal: true

avrcp_root = '3-bluetooth-profiles/avrcp'
target_root = avrcp_root + '/target'

base = avrcp_root + '/base'
player = target_root + '/player'
target = target_root + '/target'

# BASE
require "#{base}/delegation/notification_delegate_validation"
require "#{base}/delegation/notification_delegate"
require "#{base}/delegation/notification_delegator"
require "#{base}/delegation/notification_handler"
# require "#{base}/notification_listener"

# PLAYER
# require "#{player}/notifications/player_notification_handler"
# require "#{player}/signals/media_player_interface_handler"
require "#{player}/attributes"
require "#{player}/notifications"
require "#{player}/signal_handling"
require "#{player}/state"
require "#{player}/player"
# require "#{player}/track"

# TARGET
# require "#{target}/notifications/target_notification_handler"
# require "#{target}/signals/device_interface_handler"
# require "#{target}/signals/media_control_interface_handler"
require "#{target}/commands"
require "#{target}/notifications"
require "#{target}/signal_handling"
require "#{target}/target"

require "#{avrcp_root}/service"
