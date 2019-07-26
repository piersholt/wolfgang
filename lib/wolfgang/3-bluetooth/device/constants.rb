# frozen_string_literal: true

module Wolfgang
  module Bluetooth
    class Device
      # Bluetooth API: Devices
      module Constants
        PROG = 'Device'
        
        DEVICE_CONNECTED     = 'Device connected!'
        DEVICE_DISCONNECTED  = 'Device disconnected!'

        DEVICE_CONNECTING    = 'Device connecting!'
        DEVICE_DISCONNECTING = 'Device disconnecting!'

        DEVICE_CONNECT_CALLED    = 'BluezDeviceInterface.connect()'
        DEVICE_DISCONNECT_CALLED = 'BluezDeviceInterface.disconnect()'

        PROPERTY_CONNECTED  = :connected

        PROPERTY_CONNECT    = :connect
        PROPERTY_DISCONNECT = :disconnect

        def logger
          LogActually.bt_device
        end
      end
    end
  end
end
