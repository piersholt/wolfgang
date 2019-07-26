# frozen_string_literal: true

module Wolfgang
  module ObjectManager
    module Signals
      # ObjectManager::Signals::InterfacesRemoved
      class InterfacesRemoved < BaseSignal
        attr_reader :object, :removed_interfaces

        def initialize(object, removed_interfaces)
          super(interface: ObjectManager::OBJECT_MANAGER,
            member:   'InterfacesRemoved')
            @object = object
            @removed_interfaces = removed_interfaces
          end

          # @deprecated
          def object_path
            object
          end

          # @deprecated
          def changes
            removed_interfaces
          end

          def filtered_interfaces
            filter_non_bluez_array(removed_interfaces)
          end

          def object_suffixed
            interface_suffixed(object)
          end
        end
      end
    end
end
