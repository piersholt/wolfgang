# frozen_string_literal: true

class BluezDeviceObject < ObjectAdapter
  include InterfaceConstants
  include Properties

  include Callable
  # include Returnable

  include BluezDevice
  include BluezMediaControl
  include BluezNetwork
end
