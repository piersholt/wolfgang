class DBusAdapter
  def self.system_bus
    SystemBusAdapter.instance
  end
end

class SystemBusAdapter < DBus::SystemBus
  def service(service_name, adapter = ServiceAdapter)
    adapter.new(service_name, self)
  end
end
