module BluezAdapter
  include InterfaceConstants

  def start_discovery
    interface(BLUEZ_ADAPTER).StartDiscovery
  end

  def stop_discovery
    interface(BLUEZ_ADAPTER).StopDiscovery
  end

  def discoverable(bool)
    # value = bool ? 1 : 0
    property_set(BLUEZ_ADAPTER, 'Discoverable', bool)
  end

  # PROPERTIES

  def name
    adapter_property('Name')
  end

  def address
    adapter_property('Address')
  end

  def alias
    adapter_property('Alias')
  end

  def adapter
    self.default_iface = BLUEZ_ADAPTER
    @selected_interface = BLUEZ_ADAPTER
    self
  end

  private

  def adapter_property(property)
    property_get(BLUEZ_ADAPTER, property)
  end

  def adapter_properties
    property_get(BLUEZ_ADAPTER, property)
  end
end
