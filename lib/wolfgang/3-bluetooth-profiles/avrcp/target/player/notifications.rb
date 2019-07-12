# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Player
      # AVRCP::Player::Notifications
      module Notifications
        include Constants
        
        attr_accessor :notifications_queue

        MODULE_PROG = 'Player::Notifications'

        def attributes_changed!(signal)
          LogActually.avrcp.info(MODULE_PROG) { PLAYER_CHANGED }
          LogActually.avrcp.info(MODULE_PROG) { "signal.path => #{signal.path}" }
          LogActually.avrcp.info(MODULE_PROG) { "signal.removed => #{signal.removed}" }
          LogActually.avrcp.info(MODULE_PROG) { "signal.changed => #{signal.changed}" }
          LogActually.avrcp.info(MODULE_PROG) { "device => #{device}" }
          n = Yabber::Notification.new(
            topic: :player,
            name: :properties_changed,
            properties: { player: signal.path, device: device, properties: signal.changed }
          )
          notifications_queue.push(n)
        end
      end
    end
  end
end
