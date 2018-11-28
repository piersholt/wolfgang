# frozen_string_literal: true

class BluezManager
  include BluezDBusInterface
  include BluezServiceDefaults
  include BluezClientAPI::Debug
  include BluezClientAPI::Device
  include BluezClientAPI::Controller

  def initialize(selected: DEFAULT_CONTROLLER_INDEX, targeted: IPHONE_7)
    select(selected)
    target(targeted)
  end
end
