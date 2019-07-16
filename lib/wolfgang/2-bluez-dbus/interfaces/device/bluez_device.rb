# frozen_string_literal: true

module Wolfgang
  # BluezDevice Interface org.bluez.Device1
  module BluezDevice
    include InterfaceConstants
    include Constants
    include Properties
    include Methods

    def device
      self.default_iface = BLUEZ_DEVICE
      @selected_interface = BLUEZ_DEVICE
      self
    end

    private

    def device_interface
      interface(BLUEZ_DEVICE)
    end

    def device_property(property)
      logger.debug(PROG) { "#device_property(#{property})" }
      property_get(BLUEZ_DEVICE, property)
    end
  end
end
