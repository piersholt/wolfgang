# frozen_string_literal: true

module AVRCP
  class Target
    # Comment
    module Notifications
      attr_accessor :notifications_queue

      def player_added!
        LogActually.target.info(self.class) { 'Player added!' }
        n = Messaging::Notification.new(topic: :target, name: :player_added, properties: addressed_player.object.path)
        notifications_queue.push(n)
      end

      def player_changed!
        LogActually.target.info(self.class) { 'Player changed!!' }
        n = Messaging::Notification.new(topic: :target, name: :player_changed, properties: addressed_player.object.path)
        notifications_queue.push(n)
      end

      def player_removed!
        LogActually.target.info(self.class) { 'Player removed!' }
        n = Messaging::Notification.new(topic: :target, name: :player_removed)
        notifications_queue.push(n)
      end

      def device_connecting!
        LogActually.target.info(self.class) { 'Device connecting!' }
        n = Messaging::Notification.new(topic: :device, name: :device_connecting)
        notifications_queue.push(n)
      end

      def device_disconnecting!
        LogActually.target.info(self.class) { 'Device disconnecting!' }
        n = Messaging::Notification.new(topic: :device, name: :device_disconnecting)
        notifications_queue.push(n)
      end

      def device_connected!
        LogActually.target.info(self.class) { 'Device connected!' }
        n = Messaging::Notification.new(topic: :device, name: :device_connected)
        notifications_queue.push(n)
      end

      def device_disconnected!
        LogActually.target.info(self.class) { 'Device disconnected!' }
        n = Messaging::Notification.new(topic: :device, name: :device_disconnected)
        notifications_queue.push(n)
      end
    end
  end
end
