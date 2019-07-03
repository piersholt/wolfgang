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

    def inspect
      self.class
    end

    def logger
      LogActually.device
    end

    def name
      'DeviceObject'
    end
  end
end
