# frozen_string_literal: true

module Wolfgang
  module Core
    class Manager
      # Notifications
      module Notifications
        attr_accessor :notifications_queue

        def device_connecting!(device_in_question)
          LogActually.core.info('Notification') { 'Device connecting!' }
          n = Messaging::Notification.new(topic: :device, name: :device_connecting, properties: device_in_question.attributes)
          notifications_queue.push(n)
        end

        def device_disconnecting!(device_in_question)
          LogActually.core.info('Notification') { 'Device disconnecting!' }
          n = Messaging::Notification.new(topic: :device, name: :device_disconnecting, properties: device_in_question.attributes)
          notifications_queue.push(n)
        end

        def device_connected!(device_in_question)
          LogActually.core.info('Notification') { 'Device connected!' }
          n = Messaging::Notification.new(topic: :device, name: :device_connected, properties: device_in_question.attributes)
          notifications_queue.push(n)
        end

        def device_disconnected!(device_in_question)
          LogActually.core.info('Notification') { 'Device disconnected!' }
          n = Messaging::Notification.new(topic: :device, name: :device_disconnected, properties: device_in_question.attributes)
          notifications_queue.push(n)
        end
      end
    end
  end
end
