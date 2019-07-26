# frozen_string_literal: true

module Wolfgang
  # BluezDeviceListener
  class BluezDeviceListener < BaseSignalListener
    include Singleton
    include InterfaceConstants
    include SignalDelegator

    PROG = 'DeviceListener'
    LOG_REG_PROPERTIES_CHANGED = 'Signal Registration: :properties_changed.'
    LOG_REG_INTERFACE_CALLED = 'Signal Registration: :interface_called.'
    PROC_NAME_PROPERTIES_CHANGED = 'Device#PropertiesChanged'
    PROC_NAME_INTERFACE_CALLED = 'Device#InterfaceCalled'
    LOG_NOT_HANDLED = 'Chain did not handle!'

    def prog
      PROG
    end

    def logger
      LogActually.object_device
    end

    # @override PropertiesListener.properties_changed
    def properties_changed(signal)
      logger.debug(PROG) { '#properties_changed' }
      super(signal, PROC_NAME_PROPERTIES_CHANGED)
      delegate(:properties_changed, signal)
    rescue Yabber::IfYouWantSomethingDone
      logger.warn(PROG) { LOG_NOT_HANDLED }
    end

    # @override Callable.interface_called
    def interface_called(event)
      logger.debug(PROG) { "#interface_called(#{event})" }
      self.proc = PROC_NAME_INTERFACE_CALLED
      delegate(:interface_called, event)
    rescue Yabber::IfYouWantSomethingDone
      logger.warn(PROG) { LOG_NOT_HANDLED }
    end

    # Called by BluezServiceListener when initialized
    def new_device(device)
      logger.info(PROG) { "New Device! #{device.path_suffix} (#{device.class})" }

      logger.info(PROG) { "Register Signals! #{device.path_suffix}" }
      properties_changed_signal_registration(device)
      interface_called_signal_registration(device)

      logger.info(PROG) { "Fetch State! #{device.path_suffix}" }
      fetch_device_object_state(device)
    end

    private

    def properties_changed_signal_registration(device)
      logger.debug(PROG) { "#{device.path}: #{LOG_REG_PROPERTIES_CHANGED}" }
      device.properties.listen(
        :properties_changed,
        BluezDeviceListener.instance,
        method: :properties_changed,
        klass: DevicePropertiesChanged
      )
    end

    def interface_called_signal_registration(device)
      logger.debug(PROG) { "#{device.path}: #{LOG_REG_INTERFACE_CALLED}" }
      device.device.interface_called(
        BluezDeviceListener.instance,
        :interface_called
      )
    end

    public

    def fetch_device_object_state(device)
      logger.debug(PROG) { "#fetch_device_object_state(#{device})" }
      fetch_device_interface_state(device)
      fetch_media_control_interface_state(device)
    rescue StandardError => e
      logger.error(PROG) { e }
    end

    private

    def fetch_device_interface_state(device)
      logger.info(PROG) { "State Fetch: #{BLUEZ_DEVICE}" }
      device.device.property_get_all do |_, props|
        signal = DevicePropertiesChanged.new(
          device.path, BLUEZ_DEVICE, props, []
        )
        logger.debug(PROG) do
          "State Fetch: sending #{BLUEZ_DEVICE} :properties_changed signal."
        end
        public_send(:properties_changed, signal)
      end
    end

    def fetch_media_control_interface_state(device)
      logger.info(PROG) { "State Fetch: #{BLUEZ_MEDIA_CONTROL}" }
      device.media_control.property_get_all do |_, props|
        signal = DevicePropertiesChanged.new(
          device.path, BLUEZ_MEDIA_CONTROL, props, []
        )
        logger.debug(PROG) do
          "State Fetch: sending #{BLUEZ_MEDIA_CONTROL} :properties_changed signal."
        end
        public_send(:properties_changed, signal)
      end
    end
  end
end
