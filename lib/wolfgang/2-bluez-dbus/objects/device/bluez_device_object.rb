# frozen_string_literal: true

module Wolfgang
  # Bluez Device Object
  class BluezDeviceObject < ObjectAdapter
    include Properties

    include Callable
    # include Returnable

    include BluezDevice
    include BluezMediaControl
    include BluezNetwork

    NAME = 'DeviceObject'

    def inspect
      self.class
    end

    def logger
      LogActually.object_device
    end

    def name
      NAME
    end
  end
end
