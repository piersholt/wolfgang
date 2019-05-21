# frozen_string_literal: true

module BluezDevice
  # Methods of Bluez Interface: org.bluez.Device1
  module Methods
    include InterfaceConstants

    def connect
      called(BLUEZ_DEVICE, :connect, path: path)
      device_interface.Connect(&default_callback)
    end

    def disconnect
      # call_callback = fetch_callback(:disconnect)
      # call_callback.call(BLUEZ_DEVICE, :disconnect)
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
