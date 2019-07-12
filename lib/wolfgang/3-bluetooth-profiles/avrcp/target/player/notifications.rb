# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Player
      # Notifications
      module Notifications
        include Constants
        
        attr_accessor :notifications_queue, :changed

        MODULE_PROG = 'Player::Notifications'
      end
    end
  end
end
