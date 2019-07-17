# frozen_string_literal: true

module Wolfgang
  # ObjectHelpers
  module ObjectHelpers
    include ObjectConstants

    # @param Integer controller_index Index of Bluetoth adapter
    # @return String /org/bluez/hci0
    def controller_path(controller_index)
      CONTROLLER_OBJECT_PATH + controller_index.to_s
    end

    # @param Integer controller_index
    # @param Integer device_address
    # @return String '/org/bluez/hci0/dev_01_23_45_67_89_AB'
    def device_path(controller_index, device_address)
      controller_path(controller_index) + device_suffix(device_address)
    end

    # @param Integer controller_index
    # @param Integer device_address
    # @param Integer file_descriptor
    # @return String '/org/bluez/hci0/dev_01_23_45_67_89_AB/fd4'
    def transport_path(controller_index, device_address, file_descriptor)
      controller_path(controller_index) +
        device_suffix(device_address) +
        transport_suffix(file_descriptor)
    end

    # @param Integer controller_index
    # @param Integer device_address
    # @param Integer player_index
    # @return String '/org/bluez/hci0/dev_01_23_45_67_89_AB/player2'
    def player_path(controller_index, device_address, player_index)
      controller_path(controller_index) +
        device_suffix(device_address) +
        player_suffix(player_index)
    end

    # @param String device_address. Example: '01:23:45:67:89:AB'
    # @return String '/dev_01_23_45_67_89_AB'
    def device_suffix(device_address)
      DEVICE_OBJECT_PREFIX + parse_device_address(device_address)
    end

    # @param Integer file_descriptor
    # @return String '/fd4'
    def transport_suffix(file_descriptor)
      MEDIA_TRANSPORT_OBJECT_PREFIX + file_descriptor.to_s
    end

    # @param Integer player_index
    # @return String '/player2'
    def player_suffix(player_index)
      PLAYER_OBJECT_PREFIX + player_index.to_s
    end

    # @param String device_addres. Example: '01:23:45:67:89:AB'
    # @return String '01_23_45_67_89_AB'
    def parse_device_address(device_address)
      device_address.tr(DEVICE_ADDRESS_COLON, DEVICE_ADDRESS_UNDERSCORE)
    end

    # @param String target_path. Example: /org/bluez/hci0/dev_XX..
    # @return String '/hci0/dev_XX..'
    def path_suffixed(target_path = path)
      prefix_length = CORE_OBJECT_PATH.length
      target_path[prefix_length..-1]
    end

    # @param String target_namespace. Example: org.bluez.MediaControl1
    # @return String 'MediaControl1'
    def interface_suffixed(target_namespace)
      prefix_length = SERVICE_NAMESPACE.length
      target_namespace[prefix_length..-1]
    end
  end
end
