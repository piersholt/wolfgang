# frozen_string_literal: true

class BluezDeviceObject < ObjectAdapter
  include Properties

  include BluezDevice
  include BluezMediaControl
  include BluezNetwork
end
