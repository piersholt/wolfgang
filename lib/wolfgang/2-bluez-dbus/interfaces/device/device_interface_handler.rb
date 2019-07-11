# frozen_string_literal: true

module Wolfgang
  # DeviceInterfaceHandler
  class DeviceInterfaceHandler
    include Singleton
    include SignalDelegate

    PROG = 'DeviceInterfaceHandler'
    PROPERTIES_CHANGED = '#properties_changed'
    INTERFACE_CALLED = '#interface_called'

    attr_accessor :signal_callback, :call_callback

    def responsibility
      BLUEZ_DEVICE
    end

    # @override SignalDelegate
    def properties_changed(signal)
      LogActually.object_device.debug(PROG) { PROPERTIES_CHANGED }
      signal_callback.call(signal)
    end

    # @override SignalDelegate
    def interface_called(event)
      LogActually.object_device.debug(PROG) { INTERFACE_CALLED }
      call_callback.call(event)
    end
  end
end
