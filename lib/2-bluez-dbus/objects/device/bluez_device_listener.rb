# frozen_string_literal: true

class BluezDeviceListener < BaseSignalListener
  include Singleton
  include ChainDelegator

  # @override PropertiesListener
  def properties_changed(signal)
    super(signal, 'Device#PropertiesChanged')
    shirk(signal)
  rescue IfYouWantSomethingDone
    LOGGER.warn(proc) { 'Chain did not handle!' }
  end

  def new_device(device)
    device.properties
          .properties_changed(
            BluezDeviceListener.instance,
            :properties_changed,
            DevicePropertiesChanged
          )
  end
end
