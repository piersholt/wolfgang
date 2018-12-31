# frozen_string_literal: true

module Core
  class Manager
    # Comment
    module Notifications
      attr_accessor :notifications_queue

      def device_connecting!
        LogActually.core.info('Notification') { 'Device connecting!' }
        n = Messaging::Notification.new(topic: :device, name: :device_connecting)
        notifications_queue.push(n)
      end

      def device_disconnecting!
        LogActually.core.info('Notification') { 'Device disconnecting!' }
        n = Messaging::Notification.new(topic: :device, name: :device_disconnecting)
        notifications_queue.push(n)
      end

      def device_connected!
        LogActually.core.info('Notification') { 'Device connected!' }
        n = Messaging::Notification.new(topic: :device, name: :device_connected)
        notifications_queue.push(n)
      end

      def device_disconnected!
        LogActually.core.info('Notification') { 'Device disconnected!' }
        n = Messaging::Notification.new(topic: :device, name: :device_disconnected)
        notifications_queue.push(n)
      end
    end
  end
end
