# frozen_string_literal: true

module AVRCP
  class Player
    # Comment
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
        LOGGER.unknown("#{self.class}#notify") { "Track changed!" }
        n = Messaging::Notification.new(topic: :player, name: :track_change, properties: track)
        notifications_queue.push(n)
        # changed!
      end

      def track_started!
        # track_changed! unless changed?
        LOGGER.unknown("#{self.class}#notify") { "Track started!" }
        n = Messaging::Notification.new(topic: :player, name: :track_start)
        notifications_queue.push(n)
      end

      def track_ended!
        LOGGER.unknown("#{self.class}#notify") { "Track ended!" }
        n = Messaging::Notification.new(topic: :player, name: :track_end)
        notifications_queue.push(n)
      end

      def position!
        LOGGER.unknown("#{self.class}#notify") { "Position Update" }
        n = Messaging::Notification.new(topic: :player, name: :position, properties: position)
        notifications_queue.push(n)
      end

      def status!
        LOGGER.unknown("#{self.class}#notify") { "Playback Status Changed" }
        n = Messaging::Notification.new(topic: :player, name: :status, properties: status)
        notifications_queue.push(n)
      end

      def repeat!
        LOGGER.unknown("#{self.class}#notify") { "Repeat Method Changed" }
        n = Messaging::Notification.new(topic: :player, name: :repeat, properties: repeat)
        notifications_queue.push(n)
      end

      def shuffle!
        LOGGER.unknown("#{self.class}#notify") { "Shuffle Method Changed" }
        n = Messaging::Notification.new(topic: :player, name: :shuffle, properties: shuffle)
        notifications_queue.push(n)
      end
    end
  end
end
