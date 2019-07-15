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

      # @argument: uuid String
      def connect_profile(uuid); end

      # @argument: uuid String
      def disconnect_profile(uuid); end

      def pair; end

      def cancel_pairing; end
    end
  end
end
