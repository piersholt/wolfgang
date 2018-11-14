# frozen_string_literal: true

class BluezService < ServiceAdapter
  ROOT_OBJECT_PATH = '/'
  CORE_OBJECT_PATH = '/org/bluez'
  CONTROLLER_OBJECT_PATH = '/org/bluez/hci'
  DEVICE_OBJECT_PREFIX = '/dev_'
  FILE_DESCRIPTOR_OBJECT_PREFIX = '/fd'
  PLAYER_OBJECT_PREFIX = '/player'

  def objects
    root_object.managed_objects
  end

  # Get root object: '/'
  def root_object
    public_send(:[], ROOT_OBJECT_PATH, adapter: BluezRootObject)
  end

  # Get core bluez object: '/org/bluez'
  def core_object
    public_send(:[], CORE_OBJECT_PATH, adapter: BluezCoreObject)
  end

  # Get controller/adapter object: '/org/bluez/hciX'
  def controller_object(controller_index)
    path = controller_path(controller_index)
    public_send(:[], path, adapter: BluezControllerObject)
  end

  # Get device object: '/org/bluez/hciX/dev_XX_XX_XX_XX_XX_XX'
  def device_object(controller_index, device_address)
    path = device_path(controller_index, device_address)
    public_send(:[], path, adapter: BluezDeviceObject)
  end

  def media_transport_object(controller_index, device_address, file_descriptor)
    path = transport_path(controller_index, device_address, file_descriptor)
    public_send(:[], path, adapter: BluezMediaTransportObject)
  end

  def player_object(controller_index, device_address, player_index)
    path = player_path(controller_index, device_address, player_index)
    public_send(:[], path, adapter: BluezPlayerObject)
  end

  def player_object_full(path)
    public_send(:[], path, adapter: BluezPlayerObject)
  end

  private

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
    FILE_DESCRIPTOR_OBJECT_PREFIX + file_descriptor.to_s
  end

  def player_suffix(player_index)
    PLAYER_OBJECT_PREFIX + player_index.to_s
  end

  def parse_device_address(device_address)
    device_address.tr(':', '_')
  end
end
