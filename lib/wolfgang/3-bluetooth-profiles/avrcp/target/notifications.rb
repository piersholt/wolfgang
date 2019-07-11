# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Target
      # Notifications
      module Notifications
        attr_accessor :notifications_queue

        MODULE_PROG = 'Target::Notifications'

        LOG_PLAYER_ADDED = 'Player added!'
        LOG_PLAYER_CHANGED = 'Player changed'
        LOG_PLAYER_REMOVED = 'Player removed!'
        LOG_ATTRIBUTES_CHANGED = 'Player attributes changed!'

        def player_added!
          LogActually.avrcp.info(MODULE_PROG) { LOG_PLAYER_ADDED }
          n = Yabber::Notification.new(topic: :target, name: :player_added, properties: addressed_player.object.path)
          notifications_queue.push(n)
        end

        def player_changed!
          LogActually.avrcp.info(MODULE_PROG) { LOG_PLAYER_CHANGED }
          n = Yabber::Notification.new(topic: :target, name: :player_changed, properties: addressed_player.object.path)
          notifications_queue.push(n)
        end

        def player_removed!
          LogActually.avrcp.info(MODULE_PROG) { LOG_PLAYER_REMOVED }
          n = Yabber::Notification.new(topic: :target, name: :player_removed)
          notifications_queue.push(n)
        end
      end
    end
  end
end
