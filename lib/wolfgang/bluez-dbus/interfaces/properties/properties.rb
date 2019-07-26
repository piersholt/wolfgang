# frozen_string_literal: true

module Wolfgang  
  # D-BUS interface org.freedesktop.DBus.Properties
  module Properties
    include InterfaceConstants
    include Methods
    include Signals

    def properties
      self.default_iface = PROPERTIES
      @selected_interface = PROPERTIES
      self
    end

    private

    def properties_interface
      interface(PROPERTIES)
    end
  end
end
