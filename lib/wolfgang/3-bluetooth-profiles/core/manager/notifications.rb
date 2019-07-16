# frozen_string_literal: true

module Wolfgang
  module Core
    class Manager
      # Notifications
      module Notifications
        attr_accessor :notifications_queue

        LOG_DEVICE_CONNECTING    = 'Device connecting!'
        LOG_DEVICE_DISCONNECTING = 'Device disconnecting!'
        LOG_DEVICE_CONNECTED     = 'Device connected!'
        LOG_DEVICE_DISCONNECT    = 'Device disconnected!'

        MODULE_PROG = 'Manager::Notifications'

        def device_connecting!(device_in_question)
          LogActually.core.info(MODULE_PROG) { LOG_DEVICE_CONNECTING }
          n = Yabber::Notification.new(topic: :device, name: :device_connecting, properties: device_in_question.attributes)
          notifications_queue.push(n)
        end

        def device_disconnecting!(device_in_question)
          LogActually.core.info(MODULE_PROG) { LOG_DEVICE_DISCONNECTING }
          n = Yabber::Notification.new(topic: :device, name: :device_disconnecting, properties: device_in_question.attributes)
          notifications_queue.push(n)
        end

        def device_connected!(device_in_question)
          LogActually.core.info(MODULE_PROG) { LOG_DEVICE_CONNECTED }
          n = Yabber::Notification.new(topic: :device, name: :device_connected, properties: device_in_question.attributes)
          notifications_queue.push(n)
        end

        def device_disconnected!(device_in_question)
          LogActually.core.info(MODULE_PROG) { LOG_DEVICE_DISCONNECT }
          n = Yabber::Notification.new(topic: :device, name: :device_disconnected, properties: device_in_question.attributes)
          notifications_queue.push(n)
        end
      end
    end
  end
end
