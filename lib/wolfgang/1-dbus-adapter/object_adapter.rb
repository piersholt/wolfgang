# frozen_string_literal: false

module Wolfgang
  # Wolfgang::ObjectAdapter
  class ObjectAdapter < DBus::ProxyObject
    def interface(interface_name)
      self[interface_name]
    end

    def introspect
      # Synchronous call here.
      xml = @bus.introspect_data(@destination, @path)
      ProxyObjectFactoryAdapter.introspect_into(self, xml)
      define_shortcut_methods
      xml
    end

    def path_suffix
      path[10..-1]
    end

    def selected_interface
      raise(NameError, 'interface has not been selected!') unless @selected_interface
      @selected_interface
    end
  end
end
