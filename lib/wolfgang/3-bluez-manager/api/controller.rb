# frozen_string_literal: true

module Wolfgang
  module BluezClientAPI
    # Controller
    module Controller
      def list
        controller_paths = @bluez_service.controller_objects
        controller_paths.map do |path|
          controller_object = @bluez_service.controller(path)
          address = controller_object.address
          nickname = controller_object.alias
          [address, nickname]
        end
      end

      def show(controller_address = selected_controller)
        controller_object = service.controller_object(controller_address)
        controller_properties = controller_object.adapter.property_get_all
        controller_properties
      end

      def discoverable(bool, controller_address = selected_controller)
        controller_object = @bluez_service.controller_object(controller_address)
        controller_object.discoverable(bool)
      end

      def select(controller_address)
        @selected_controller = controller_address
      end

      def selected_controller
        raise(NameError, 'No default controller!') unless @selected_controller
        @selected_controller
      end
    end
  end
end
