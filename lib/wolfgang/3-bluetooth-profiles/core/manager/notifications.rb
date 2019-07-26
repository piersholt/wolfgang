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

        def device_connecting!(signal)
          LogActually.core.info(MODULE_PROG) { LOG_DEVICE_CONNECTING }
          n = Yabber::Notification.new(
            topic: :device,
            name: :device_connecting,
            properties: { device: signal.path, properties: signal.changed }
          )
          notifications_queue.push(n)
        end

        def device_disconnecting!(signal)
          LogActually.core.info(MODULE_PROG) { LOG_DEVICE_DISCONNECTING }
          n = Yabber::Notification.new(
            topic: :device,
            name: :device_disconnecting,
            properties: { device: signal.path, properties: signal.changed }
          )
          notifications_queue.push(n)
        end

        def device_connected!(signal)
          LogActually.core.info(MODULE_PROG) { LOG_DEVICE_CONNECTED }
          n = Yabber::Notification.new(
            topic: :device,
            name: :device_connected,
            properties: { device: signal.path, properties: signal.changed }
          )
          notifications_queue.push(n)
        end

        def device_disconnected!(signal)
          LogActually.core.info(MODULE_PROG) { LOG_DEVICE_DISCONNECT }
          n = Yabber::Notification.new(
            topic: :device,
            name: :device_disconnected,
            properties: { device: signal.path, properties: signal.changed }
          )
          notifications_queue.push(n)
        end
      end
    end
  end
end
