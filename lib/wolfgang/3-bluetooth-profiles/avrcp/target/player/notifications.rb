# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Player
      # Notifications
      module Notifications
        attr_accessor :notifications_queue, :changed

        MODULE_PROG = 'Player::Notifications'

        LOG_TRACK_CHANGED = 'Track changed!'
        LOG_TRACK_STARTED = 'Track started!'
        LOG_TRACK_ENDED = 'Track ended!'
        LOG_POSITION = 'Position Update'
        LOG_STATUS = 'Playback Status changed'
        LOG_REPEAT = 'Repeat Method changed'
        LOG_SHUFFLE = 'Shuffle Method changed'
        LOG_ATTRIBUTES_CHANGED = 'Player attributes changed'

        def time(milliseconds)
          seconds = milliseconds / 1000
          seconds.divmod(60)
        end

        def track_changed!
          LogActually.avrcp.info(MODULE_PROG) { LOG_TRACK_CHANGED }
          n = Yabber::Notification.new(topic: :player, name: :track_change, properties: attributes)
          notifications_queue.push(n)
          # changed!
        end

        def track_started!
          LogActually.avrcp.info(MODULE_PROG) { LOG_TRACK_STARTED }
          n = Yabber::Notification.new(topic: :player, name: :track_start, properties: attributes)
          notifications_queue.push(n)
        end

        def track_ended!
          LogActually.avrcp.info(MODULE_PROG) { LOG_TRACK_ENDED }
          n = Yabber::Notification.new(topic: :player, name: :track_end, properties: attributes)
          notifications_queue.push(n)
        end

        def position!
          LogActually.avrcp.info(MODULE_PROG) { LOG_POSITION }
          n = Yabber::Notification.new(topic: :player, name: :position, properties: attributes)
          notifications_queue.push(n)
        end

        def status!
          LogActually.avrcp.info(MODULE_PROG) { LOG_STATUS }
          n = Yabber::Notification.new(topic: :player, name: :status, properties: attributes)
          notifications_queue.push(n)
        end

        def repeat!
          LogActually.avrcp.info(MODULE_PROG) { LOG_REPEAT }
          n = Yabber::Notification.new(topic: :player, name: :repeat, properties: attributes)
          notifications_queue.push(n)
        end

        def shuffle!
          LogActually.avrcp.info(MODULE_PROG) { LOG_SHUFFLE }
          n = Yabber::Notification.new(topic: :player, name: :shuffle, properties: attributes)
          notifications_queue.push(n)
        end
      end
    end
  end
end
