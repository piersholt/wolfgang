# frozen_string_literal: true

media_player_root = '4-media-player'

root = media_player_root

require "#{root}/notification"
require "#{root}/notification_delegator"
require "#{root}/notification_delegate"
require "#{root}/notification_handler"
require "#{root}/device_notification_handler"
require "#{root}/media_notification_handler"
require "#{root}/notification_listener"
require "#{root}/player"
require "#{root}/media_player"
