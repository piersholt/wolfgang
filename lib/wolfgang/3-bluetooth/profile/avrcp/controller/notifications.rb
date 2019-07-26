# frozen_string_literal: true

require_relative 'notifications/media_control'
require_relative 'notifications/media_player'

module Wolfgang
  module Bluetooth
    module Profile
      module AVRCP
        class Controller
          # Profile::AVRCP::Controller::Notifications
          module Notifications
            attr_accessor :notifications_queue

            MODULE_PROG = 'Controller::Notifications'

            include MediaControl
            include MediaPlayer
          end
        end
      end
    end
  end
end
