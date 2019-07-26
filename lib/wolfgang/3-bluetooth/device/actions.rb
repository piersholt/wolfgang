# frozen_string_literal: true

module Wolfgang
  module Bluetooth
    class Device
      # Device::Notifications
      module Actions
        include Yabber::Constants
        include Constants

        MODULE_PROG = 'Device::Actions'

        def connect(path)
          logger.debug(PROG) { "#connect(#{path})" }
          device_connecting!(device_references.fetch(path))
          device_references.fetch(path)&.connect
        end

        def disconnect(path)
          logger.debug(PROG) { "#disconnect(#{path})" }
          device_disconnecting!(device_references.fetch(path))
          device_references.fetch(path)&.disconnect
        end
      end
    end
  end
end
