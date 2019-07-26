# frozen_string_literal: true

require_relative 'signals/called'
require_relative 'signals/device'

module Wolfgang
  module Bluetooth
    # Bluetooth API: Devices
    class Device
      # Device::Signals
      module Signals
        MODULE_PROG = 'Device::Signals'

        include Device
        include Called
      end
    end
  end
end
