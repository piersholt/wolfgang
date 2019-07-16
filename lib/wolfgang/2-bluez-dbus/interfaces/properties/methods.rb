# frozen_string_literal: true

module Wolfgang
  module Properties
    # Methods of DBUS interface org.freedesktop.DBus.Properties
    module Methods
      include InterfaceConstants
      PROG = 'Properties'

      def property_get(interface_name = selected_interface, property_name)
        logger.debug(respond_to?(:prog) ? prog : PROG) { "#property_get(#{interface_name}, #{property_name})" }
        properties_interface.Get(interface_name, property_name)
      end

      # @desc:  Sets the specified property. Similar to Get, the interface_name
      # argument may be ''.
      def property_set(interface_name = selected_interface, property_name, value)
        properties_interface.Set(interface_name, property_name, value)
      end

      # @return: a dictionary of string property names to variant values.
      def property_get_all(interface_name = selected_interface)
        logger.debug(respond_to?(:prog) ? prog : PROG) { "#property_get_all(#{interface_name})" }
        properties_interface.GetAll(interface_name)
      end

      # alias properties property_get_all
    end
  end
end
