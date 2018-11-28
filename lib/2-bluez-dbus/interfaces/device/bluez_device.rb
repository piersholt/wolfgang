module BluezDevice
  include InterfaceConstants

  # Properties

  def connected?
    device_property('Connected')
  end

  def name
    device_property('Name')
  end

  def address
    device_property('Address')
  end

  def klass
    device_property('Class')
  end

  def uuids
    device_property('UUIDs')
  end

  def trusted?
    device_property('Trusted')
  end

  def blocked?
    device_property('Blocked')
  end

  def alias
    device_property('Alias')
  end

  def adapter
    device_property('Adapter')
  end

  def device
    self.default_iface = BLUEZ_DEVICE
    @selected_interface = BLUEZ_DEVICE
    self
  end

  private

  def device_property(property)
    property_get(BLUEZ_DEVICE, property)
  end
end
