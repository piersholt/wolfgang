# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Target
      # AVRCP::Target::Notifications
      module Notifications
        include Constants
        
        attr_accessor :notifications_queue

        MODULE_PROG = 'Target::Notifications'

        def player_added!(signal)
          LogActually.avrcp.info(MODULE_PROG) { PLAYER_ADDED }
          n = Yabber::Notification.new(
            topic: :target,
            name: :player_added,
            properties: { device: signal.path, properties: signal.changed }
          )
          notifications_queue.push(n)
        end

        def player_changed!(signal)
          LogActually.avrcp.info(MODULE_PROG) { PLAYER_CHANGED }
          n = Yabber::Notification.new(
            topic: :target,
            name: :player_changed,
            properties: { device: signal.path, properties: signal.changed }
          )
          notifications_queue.push(n)
        end

        def player_removed!(signal)
          LogActually.avrcp.info(MODULE_PROG) { PLAYER_REMOVED }
          n = Yabber::Notification.new(
            topic: :target,
            name: :player_removed,
            properties: { device: signal.path }
          )
          notifications_queue.push(n)
        end
      end
    end
  end
end
