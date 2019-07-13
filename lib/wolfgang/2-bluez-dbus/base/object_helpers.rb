# frozen_string_literal: true

module Wolfgang
  # ObjectHelpers
  module ObjectHelpers
    include ObjectConstants

    def take_a_variable_and_get_a_path(variable); end

    def controller_path(controller_index)
      CONTROLLER_OBJECT_PATH + controller_index.to_s
    end

    def device_path(controller_index, device_address)
      controller_path(controller_index) + device_suffix(device_address)
    end

    def transport_path(controller_index, device_address, file_descriptor)
      controller_path(controller_index) +
        device_suffix(device_address) +
        transport_suffix(file_descriptor)
    end

    def player_path(controller_index, device_address, player_index)
      controller_path(controller_index) +
        device_suffix(device_address) +
        player_suffix(player_index)
    end

    def device_suffix(device_address)
      DEVICE_OBJECT_PREFIX + parse_device_address(device_address)
    end

    def transport_suffix(file_descriptor)
      MEDIA_TRANSPORT_OBJECT_PREFIX + file_descriptor.to_s
    end

    def player_suffix(player_index)
      PLAYER_OBJECT_PREFIX + player_index.to_s
    end

    def parse_device_address(device_address)
      device_address.tr(DEVICE_ADDRESS_COLON, DEVICE_ADDRESS_UNDERSCORE)
    end

    def path_suffixed(target_path = path)
      prefix_length = CORE_OBJECT_PATH.length
      target_path[prefix_length..-1]
    end

    def interface_suffixed(target_namespace)
      prefix_length = SERVICE_NAMESPACE.length
      target_namespace[prefix_length..-1]
    end
  end
end
