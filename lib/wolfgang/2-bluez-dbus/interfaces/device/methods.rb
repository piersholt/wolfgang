# frozen_string_literal: true

module Wolfgang
  module BluezDevice
    # Methods of Bluez Interface: org.bluez.Device1
    module Methods
      include InterfaceConstants

      def connect
        called(BLUEZ_DEVICE, :connect, path: path)
        device_interface.Connect(&default_callback)
      end

      def disconnect
        called(BLUEZ_DEVICE, :disconnect, path: path)
        device_interface.Disconnect(&default_callback)
      end

      # @param String uuid
      def connect_profile(uuid)
        called(BLUEZ_DEVICE, :connect_profile, uuid: uuid)
        device_interface.ConnectProfile(uuid, &default_callback)
      end

      # @param String uuid
      def disconnect_profile(uuid)
        called(BLUEZ_DEVICE, :disconnect_profile, uuid: uuid)
        device_interface.DisconnectProfile(uuid, &default_callback)
      end

      def pair
        called(BLUEZ_DEVICE, :pair)
        device_interface.Pair(&default_callback)
      end

      def cancel_pairing
        called(BLUEZ_DEVICE, :cancel_pairing)
        device_interface.CancelPairing(&default_callback)
      end
    end
  end
end
