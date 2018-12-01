module BluezDevice
  include InterfaceConstants

  # METHODS

  def connect
    device_interface.Connect do |resp|
      LOGGER.info('Callback') { "result: #{resp}" }
    end
  end

  def disconnect
    device_interface.Disconnect do |resp|
      LOGGER.info('Callback') { "result: #{resp}" }
    end
  end

  # @argument: uuid String
  def connect_profile(uuid); end

  def disconnect_profile(uuid); end

  def pair; end

  def cancel_pairing; end

  # Properties

  def connected?
    device_property('Connected')
  end

  def paired?
    device_property('Paired')
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

  def device_interface
    interface(BLUEZ_DEVICE)
  end

  def device_property(property)
    property_get(BLUEZ_DEVICE, property)
  end
end
