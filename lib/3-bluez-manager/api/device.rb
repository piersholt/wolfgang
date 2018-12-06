# frozen_string_literal: true

module BluezClientAPI::Device
  include BluezClientAPI::Service

  def devices
    device_paths = service.device_objects
    device_paths.map do |path|
      device_object = service.device(path)
      address = device_object.device.address
      nickname = device_object.device.alias
      [address, nickname]
    end
  end

  def info(device_address = selected_device)
    device_object = service.device(device_address)
    device_properties = device_object.device.property_get_all
    device_properties
  end

  def target(device_address)
    @selected_device = device_address
  end

  def connect(device_address = selected_device)
    LOGGER.info(self.class) { "Device: #{device_address}" }
    device_object = service.device(device_address)
    device_object.connect
  end

  def disconnect(device_address = selected_device)
    LOGGER.info(self.class) { "Device: #{device_address}" }
    device_object = service.device(device_address)
    device_object.disconnect
  end

  def selected_device
    raise(NameError, 'No connected device!') unless @selected_device
    @selected_device
  end
end
