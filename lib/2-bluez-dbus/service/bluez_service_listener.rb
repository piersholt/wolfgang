# bluez_service_listener.rb

# frozen_string_literal: true

class BluezServiceListener
  include Singleton
  PROC = 'BluezServiceListener'

  # pi@raspberrypi:~$ sudo bluetoothctl
  # [NEW] Controller B8:27:EB:E2:79:E7 pi_usb [default]
  # [NEW] Device 70:70:0D:11:CF:29 P7
  # [NEW] Device 4C:8D:79:8C:A0:94 P5
  # [NEW] Controller 00:1A:7D:DA:71:13 raspberrypi
  def new_service(service,
                  root: BluezRootListener,
                  controller: BluezControllerListener,
                  device: BluezDeviceListener)
    LOGGER.info(PROC) { 'New Service!' }

    initialize_root(service, root)
    initialize_controllers(service, controller)
    initialize_devices(service, device)
  end

  # @desc: called on quiting Bluez
  def delete_service; end

  private

  def initialize_root(service, root_klass)
    LOGGER.warn(PROC) { "Initialize Root! Listener Klass: #{root_klass}" }
    new_root = service.root_object
    root_listener = root_klass.instance
    root_listener.new_root(new_root)
  end

  def initialize_controllers(service, controller_klass)
    LOGGER.warn(PROC) { "Initialize Controllers! Listener Klass: #{controller_klass}" }
    controller_listener = controller_klass.instance
    service.controller_objects.each do |controller_path|
      new_controller = service.controller(controller_path)
      controller_listener.new_controller(new_controller)
    end
  end

  def initialize_devices(service, device_klass)
    LOGGER.warn(PROC) { "Initialize Devices! Listener Klass: #{device_klass}" }
    device_listener = device_klass.instance
    service.device_objects.each do |device_path|
      new_device = service.device(device_path)
      device_listener.new_device(new_device)
    end
  end
end
