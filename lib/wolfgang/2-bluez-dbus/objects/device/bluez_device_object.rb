# frozen_string_literal: true

module Wolfgang
  # Bluez Device Object
  class BluezDeviceObject < ObjectAdapter
    include Properties

    include Callable

    include BluezDevice
    include BluezMediaControl
    include BluezNetwork

    PROG = 'DeviceObject'

    def inspect
      self.class
    end

    def logger
      LogActually.object_device
    end
  end
end
