# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Player
      # Notifications
      module Notifications
        attr_accessor :notifications_queue, :changed

        def time(milliseconds)
          seconds = milliseconds / 1000
          seconds.divmod(60)
        end

        def changed?
          @changed ||= false
        end

        def changed!
          @changed = true
        end

        def track_changed!
          LogActually.avrcp.info('Notificaion') { "Track changed!" }
          n = Messaging::Notification.new(topic: :player, name: :track_change, properties: attributes)
          notifications_queue.push(n)
          # changed!
        end

        def track_started!
          # track_changed! unless changed?
          LogActually.avrcp.info('Notificaion') { "Track started!" }
          n = Messaging::Notification.new(topic: :player, name: :track_start, properties: attributes)
          notifications_queue.push(n)
        end

        def track_ended!
          LogActually.avrcp.info('Notificaion') { "Track ended!" }
          n = Messaging::Notification.new(topic: :player, name: :track_end, properties: attributes)
          notifications_queue.push(n)
        end

        def position!
          LogActually.avrcp.info('Notificaion') { "Position Update" }
          n = Messaging::Notification.new(topic: :player, name: :position, properties: attributes)
          notifications_queue.push(n)
        end

        def status!
          LogActually.avrcp.info('Notificaion') { "Playback Status Changed" }
          n = Messaging::Notification.new(topic: :player, name: :status, properties: attributes)
          notifications_queue.push(n)
        end

        def repeat!
          LogActually.avrcp.info('Notificaion') { "Repeat Method Changed" }
          n = Messaging::Notification.new(topic: :player, name: :repeat, properties: attributes)
          notifications_queue.push(n)
        end

        def shuffle!
          LogActually.avrcp.info('Notificaion') { "Shuffle Method Changed" }
          n = Messaging::Notification.new(topic: :player, name: :shuffle, properties: attributes)
          notifications_queue.push(n)
        end
      end
    end
  end
end
