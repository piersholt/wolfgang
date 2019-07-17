# frozen_string_literal: false

module Wolfgang
  # Wolfgang::DBusAdapter
  class DBusAdapter
    def self.system_bus
      SystemBusAdapter.instance
    end
  end

  # Wolfgang::SystemBusAdapter
  class SystemBusAdapter < DBus::SystemBus
    def service(service_name, adapter = ServiceAdapter)
      adapter.new(service_name, self)
    end
  end
end
