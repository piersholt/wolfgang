# frozen_string_literal: true

require 'observer'

module Properties
  include InterfaceConstants
  include Properties::Signals

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

  def properties
    self.default_iface = PROPERTIES
    @selected_interface = PROPERTIES
    self
  end

  def properties_interface
    interface(PROPERTIES)
  end
end
