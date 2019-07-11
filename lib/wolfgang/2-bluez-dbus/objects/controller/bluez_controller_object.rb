# frozen_string_literal: true

module Wolfgang
  # Bluez Controller Object
  class BluezControllerObject < ObjectAdapter
    include Properties

    include BluezAdapter
    # include BluezGattManager
    # include BluezMedia
    # include BluezNetworkServer

    def inspect
      self.class
    end

    def name
      'BluezControllerObject'
    end

    def logger
      LogActually.object_controller
    end
  end
end
