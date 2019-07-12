# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Player
      # AVRCP::Player::Notifications
      module Notifications
        include Constants
        
        attr_accessor :notifications_queue

        MODULE_PROG = 'Player::Notifications'
      end
    end
  end
end
