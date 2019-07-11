# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Target
      # Notifications
      module Notifications
        include Constants
        
        attr_accessor :notifications_queue

        MODULE_PROG = 'Target::Notifications'

        def player_added!
          LogActually.avrcp.info(MODULE_PROG) { PLAYER_ADDED }
          n = Yabber::Notification.new(topic: :target, name: :player_added, properties: addressed_player.object.path)
          notifications_queue.push(n)
        end

        def player_changed!
          LogActually.avrcp.info(MODULE_PROG) { PLAYER_CHANGED }
          n = Yabber::Notification.new(topic: :target, name: :player_changed, properties: addressed_player.object.path)
          notifications_queue.push(n)
        end

        def player_removed!
          LogActually.avrcp.info(MODULE_PROG) { PLAYER_REMOVED }
          n = Yabber::Notification.new(topic: :target, name: :player_removed)
          notifications_queue.push(n)
        end
      end
    end
  end
end
