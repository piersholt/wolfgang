# frozen_string_literal: true

module Wolfgang
  module ObjectManager
    module Signals
      # ObjectManager::Signals::InterfacesAdded
      class InterfacesAdded < BaseSignal
        attr_reader :object, :added_interfaces

        def initialize(object, added_interfaces)
          super(
            interface: ObjectManager::OBJECT_MANAGER,
            member:   'InterfacesAdded'
          )
          @object = object
          @added_interfaces = added_interfaces
        end

        # @deprecated
        def changes
          added_interfaces
        end

        # @deprecated
        def object_path
          object
        end

        def filtered_interfaces
          filter_non_bluez_hash(added_interfaces)
        end

        def interface_names
          filter_non_bluez_array(added_interfaces.keys)
        end

        def object_suffixed
          interface_suffixed(object)
        end
      end
    end
  end
end
