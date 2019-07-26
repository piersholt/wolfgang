# frozen_string_literal: true

module Wolfgang
  module Bluetooth
    class Device
      # Device::Notifications
      module Notifications
        include Constants
        attr_accessor :notifications_queue

        MODULE_PROG = 'Device::Notifications'

        def device_connected!(signal)
          logger.info(MODULE_PROG) { DEVICE_CONNECTED }
          n = Yabber::Notification.new(
            topic: :device,
            name: :connected,
            properties: { path: signal.path, **signal.changed }
          )
          notifications_queue.push(n)
        end

        def device_disconnected!(signal)
          logger.info(MODULE_PROG) { DEVICE_DISCONNECTED }
          n = Yabber::Notification.new(
            topic: :device,
            name: :disconnected,
            properties: { path: signal.path, **signal.changed }
          )
          notifications_queue.push(n)
        end

        def device_connecting!(signal)
          logger.info(MODULE_PROG) { DEVICE_CONNECTING }
          n = Yabber::Notification.new(
            topic: :device,
            name: :connecting,
            properties: { path: signal.path }
          )
          notifications_queue.push(n)
        end

        def device_disconnecting!(signal)
          logger.info(MODULE_PROG) { DEVICE_DISCONNECTING }
          n = Yabber::Notification.new(
            topic: :device,
            name: :disconnecting,
            properties: { path: signal.path }
          )
          notifications_queue.push(n)
        end
      end
    end
  end
end
