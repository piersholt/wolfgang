# frozen_string_literal: true

module Wolfgang
  # InterfaceCalled
  class InterfaceCalled
    attr_reader :interface, :method, :properties
    alias target interface

    def initialize(interface_name, method_name, properties = {})
      @interface = interface_name
      @method = method_name
      @properties = properties
    end

    def this_interface?(that_interface)
      interface == that_interface
    end
  end
end
