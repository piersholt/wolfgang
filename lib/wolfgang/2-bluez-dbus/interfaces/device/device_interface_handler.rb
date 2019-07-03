# frozen_string_literal: true

module Wolfgang
  # DeviceInterfaceHandler
  class DeviceInterfaceHandler
    include Singleton
    include SignalDelegate

    # attr_accessor :mq
    attr_accessor :signal_callback, :call_callback

    def responsibility
      BLUEZ_DEVICE
    end

    # @override SignalDelegate
    def properties_changed(signal)
      # binding.pry
      LogActually.device.debug('DeviceInterfaceHandler') { '#properties_changed' }
      signal_callback.call(signal)
    end

    # @override SignalDelegate
    # def properties_changed(signal)
    #   if signal.only?('Connected') && signal.connected?
    #     device_connected
    #   elsif signal.only?('Connected') && signal.disconnected?
    #     device_disconnected
    #   end
    # end

    # @override SignalDelegate
    def interface_called(event)
      LogActually.device.debug('DeviceInterfaceHandler') { '#interface_called' }
      call_callback.call(event)
    end

    # @override SignalDelegate
    # def interface_called(event)
    #   if event.method == :connect
    #     device_connecting
    #   elsif event.method == :disconnect
    #     device_disconnecting
    #   end
    # end

    private

    # ------------------------------ Callable ------------------------------

    # def device_connecting
    #   LOGGER.unknown(self.class) { '#connect: Device connecting...' }
    #   # n = Messaging::Notification.new(topic: :device, name: :device_connecting)
    #   # mq.push(n)
    # end
    #
    # def device_disconnecting
    #   LOGGER.unknown(self.class) { '#disconnect: Device disconnecting...' }
    #   # n = Messaging::Notification.new(topic: :device, name: :device_disconnecting)
    #   # mq.push(n)
    # end
    #
    # # ------------------------------ Signal ------------------------------
    #
    # def device_connected
    #   LOGGER.unknown(self.class) { 'Device connected!' }
    #   # n = Messaging::Notification.new(topic: :device, name: :device_connected)
    #   # mq.push(n)
    # end
    #
    # def device_disconnected
    #   LOGGER.unknown(self.class) { 'Device disconnected!' }
    #   # n = Messaging::Notification.new(topic: :device, name: :device_disconnected)
    #   # mq.push(n)
    # end
  end
end
