# frozen_string_literal: true

# Comment
module BluezDevice
  include InterfaceConstants
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
    logger.debug(name) { "#device_property(#{property})" }
    property_get(BLUEZ_DEVICE, property)
  end
end