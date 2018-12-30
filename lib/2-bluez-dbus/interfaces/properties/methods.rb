# frozen_string_literal: true

require 'observer'

module Properties
  # Methods of DBUS interface org.freedesktop.DBus.Properties
  module Methods
    include InterfaceConstants

    def property_get(interface_name = selected_interface, property_name)
      LOGGER.warn('Properties') { "#property_get(#{interface_name}, #{property_name})" }
      properties_interface.Get(interface_name, property_name)
    end

    # @desc:  Sets the specified property. Similar to Get, the interface_name
    # argument may be ''.
    def property_set(interface_name = selected_interface, property_name, value)
      properties_interface.Set(interface_name, property_name, value)
    end

    # @return: a dictionary of string property names to variant values.
    def property_get_all(interface_name = selected_interface)
      properties_interface.GetAll(interface_name)
    end
  end
end
