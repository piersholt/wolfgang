module BluezAdapter
  BLUEZ_ADAPTER = 'org.bluez.Adapter1'.freeze

  def start_discovery
    interface(BLUEZ_ADAPTER).StartDiscovery
  end

  def stop_discovery
    interface(BLUEZ_ADAPTER).StopDiscovery
  end
end
