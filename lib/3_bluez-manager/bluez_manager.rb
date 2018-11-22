# frozen_string_literal: true

class BluezManager
  include BluezInterface
  include BluezServiceDefaults
  include BluezClientAPI::Debug
  include BluezClientAPI::Device
  include BluezClientAPI::Controller

  def initialize
    select(DEFAULT_CONTROLLER_INDEX)
    target(IPHONE_7)
    signals
    run

    binding.pry
  end
end
