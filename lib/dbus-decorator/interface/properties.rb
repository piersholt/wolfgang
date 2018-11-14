# frozen_string_literal: true

require 'observer'

module Properties
  include Observable

  PROPERTIES = 'org.freedesktop.DBus.Properties'.freeze

  def property_get(interface_name, property_name)
    properties_interface.Get(interface_name, property_name)
  end

  # @desc:  Sets the specified property. Similar to Get, the interface_name
  # argument may be ''.
  def property_set(interface_name, property_name, value)
    properties_interface.Set(interface_name, property_name, value)
  end

  # @return: a dictionary of string property names to variant values.
  def property_get_all(interface_name)
    properties_interface.GetAll(interface_name)
  end

  def subscribe_to_changes
    signal = 'PropertiesChanged'
    mega_interface_one = properties_interface
    # binding.pry if self.instance_of?(BluezPlayerObject)
    mega_interface_one.on_signal(signal) do |i, h, a|
      LOGGER.debug(path_suffix) { "Object: #{self}" }
      LOGGER.debug(path_suffix) { "Observers: #{count_observers}" }
      LOGGER.debug(path_suffix) { "Interface: #{i}" }
      LOGGER.debug(path_suffix) { "Signal: #{signal}" }
      LOGGER.debug(path_suffix) { "Changes: #{h}" }
      LOGGER.debug(path_suffix) { "Removed?: #{a}" }

      changed(true)
      args = { p: path_suffix, changes: h, removed: a }
      notify_observers(i, signal, args)
    end
  end

  def properties_interface
    interface(PROPERTIES)
  end

  def properties
    props = interfaces.map do |i|
      all_properties = property_get_all(i)
      property_names = all_properties.keys
      [i, property_names]
    end
    props.sort! { |a, b| a[0] <=> b[0] }
    props.to_h
  end
end
