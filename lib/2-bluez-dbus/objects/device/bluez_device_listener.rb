# frozen_string_literal: true

class BluezDeviceListener < BaseSignalListener
  include Singleton
  include SignalDelegator

  def interface_called(event)
    # LOGGER.unknown(BluezDeviceListener) { "#{method_name} called!" }
    self.proc = 'Device#InterfaceCalled'
    delegate(:interface_called, event)
  rescue IfYouWantSomethingDone
    LOGGER.warn(self.class) { 'Chain did not handle!' }
  end

  # @override PropertiesListener
  def properties_changed(signal)
    super(signal, 'Device#PropertiesChanged')
    delegate(:properties_changed, signal)
  rescue IfYouWantSomethingDone
    LOGGER.warn(self.class) { 'Chain did not handle!' }
  end

  def new_device(device)
    device.properties
          .properties_changed(
            BluezDeviceListener.instance,
            :properties_changed,
            DevicePropertiesChanged
          )

    device.device
          .interface_called(
            BluezDeviceListener.instance,
            :interface_called
          )
  end
end
