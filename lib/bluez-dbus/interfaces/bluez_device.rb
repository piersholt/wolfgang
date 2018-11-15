module BluezDevice
  def connect
  end

  def disconnect
  end

  def connect_profile(uuid)
  end

  def disconnect_profile(uuid)
  end

  def pair
  end

  def cancel_pairing
  end

  # PROPERTIES

  def connected?
    property_get(BLUEZ_DEVICE, 'Connected')
  end

  def address
    property_get(BLUEZ_DEVICE, 'Address')
  end

  def klass
    property_get(BLUEZ_DEVICE, 'Class')
  end

  def uuids
    property_get(BLUEZ_DEVICE, 'UUIDs')
  end

  def trusted?
    property_get(BLUEZ_DEVICE, 'Trusted')
  end

  def blocked?
    property_get(BLUEZ_DEVICE, 'Blocked')
  end

  def alias
    property_get(BLUEZ_DEVICE, 'Alias')
  end

  def adapter
    property_get(BLUEZ_DEVICE, 'Adapter')
  end
end
