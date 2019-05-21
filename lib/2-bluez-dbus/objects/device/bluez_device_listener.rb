# frozen_string_literal: true

class BluezDeviceListener < BaseSignalListener
  include Singleton
  include InterfaceConstants
  include SignalDelegator

  def logger
    LogActually.device
  end

  def name
    'DeviceListener'
  end

  def interface_called(event)
    logger.debug(name) { "#interface_called(#{event})" }
    # logger.debug(name) { "#{method_name} called!" }
    self.proc = 'Device#InterfaceCalled'
    delegate(:interface_called, event)
  rescue IfYouWantSomethingDone
    logger.warn(self.class) { 'Chain did not handle!' }
  end

  # @override PropertiesListener
  def properties_changed(signal)
    logger.debug(name) { "#properties_changed" }
    super(signal, 'Device#PropertiesChanged')
    delegate(:properties_changed, signal)
  rescue IfYouWantSomethingDone
    logger.warn(self.class) { 'Chain did not handle!' }
  end

  DEFAULT_INDENT_DEPTH = 2

  def fetch_current_state!(device)
    # logger.debug(name) { '#fetch_current_state!' }
    # logger.unknown(name) { "Interface: #{BLUEZ_DEVICE}" }
    # logger.unknown(name) { "\tObject device name: #{device.device.name}" }
    # parse_properties(device_interface_props)
    logger.debug(name) { "State Fetch: #{BLUEZ_DEVICE}" }
    device_interface_props = device.device.property_get_all
    signal = DevicePropertiesChanged.new(device.path, BLUEZ_DEVICE, device_interface_props, [])
    logger.debug(name) { "State Fetch: sending #{BLUEZ_DEVICE} :properties_changed signal." }
    public_send(:properties_changed, signal)
    # logger.unknown(name) { "Interface: #{BLUEZ_MEDIA_CONTROL}" }
    # logger.unknown(name) { "\tObject device name: #{device.media_control.name}" }
    # parse_properties(device.media_control.property_get_all)

    logger.debug(name) { "State Fetch: #{BLUEZ_MEDIA_CONTROL}" }
    media_control_interface_props = device.media_control.property_get_all
    signal = DevicePropertiesChanged.new(device.path, BLUEZ_MEDIA_CONTROL, media_control_interface_props, [])
    logger.debug(name) { "State Fetch: sending #{BLUEZ_MEDIA_CONTROL} :properties_changed signal." }
    public_send(:properties_changed, signal)
  rescue StandardError => e
      logger.warn(name) { e }
  end

  def new_device(device)
    # self.proc = 'Device'
    logger.debug(name) { "New Device! #{device.path_suffix}" }
    logger.debug(name) { "New device class => #{device.class}" }
    properties_changed_signal_registration(device)
    interface_called_signal_registration(device)
    fetch_current_state!(device)
  end

  private

  def properties_changed_signal_registration(device)
    logger.debug(name) { 'Signal Registration: :properties_changed.' }
    device.properties.listen(:properties_changed,
                             BluezDeviceListener.instance,
                             method: :properties_changed,
                             klass: DevicePropertiesChanged)
  end

  def interface_called_signal_registration(device)
    logger.debug(name) { 'Signal Registration: :interface_called.' }
    device.device.interface_called(BluezDeviceListener.instance,
                                   :interface_called)
  end
end
