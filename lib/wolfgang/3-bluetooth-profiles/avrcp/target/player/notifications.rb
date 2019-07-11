# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Player
      # Notifications
      module Notifications
        include Constants
        
        attr_accessor :notifications_queue, :changed

        MODULE_PROG = 'Player::Notifications'

        def time(milliseconds)
          seconds = milliseconds / 1000
          seconds.divmod(60)
        end

        def track_changed!
          LogActually.avrcp.info(MODULE_PROG) { TRACK_CHANGED }
          n = Yabber::Notification.new(topic: :player, name: :track_change, properties: attributes)
          notifications_queue.push(n)
          # changed!
        end

        def track_started!
          LogActually.avrcp.info(MODULE_PROG) { TRACK_STARTED }
          n = Yabber::Notification.new(topic: :player, name: :track_start, properties: attributes)
          notifications_queue.push(n)
        end

        def track_ended!
          LogActually.avrcp.info(MODULE_PROG) { TRACK_ENDED }
          n = Yabber::Notification.new(topic: :player, name: :track_end, properties: attributes)
          notifications_queue.push(n)
        end

        def position!
          LogActually.avrcp.info(MODULE_PROG) { POSITION_CHANGED }
          n = Yabber::Notification.new(topic: :player, name: :position, properties: attributes)
          notifications_queue.push(n)
        end

        def status!
          LogActually.avrcp.info(MODULE_PROG) { STATUS_CHANGED }
          n = Yabber::Notification.new(topic: :player, name: :status, properties: attributes)
          notifications_queue.push(n)
        end

        def repeat!
          LogActually.avrcp.info(MODULE_PROG) { REPEAT_CHANGED }
          n = Yabber::Notification.new(topic: :player, name: :repeat, properties: attributes)
          notifications_queue.push(n)
        end

        def shuffle!
          LogActually.avrcp.info(MODULE_PROG) { SHUFFLE_CHANGED }
          n = Yabber::Notification.new(topic: :player, name: :shuffle, properties: attributes)
          notifications_queue.push(n)
        end
      end
    end
  end
end
