# frozen_string_literal: true

module Wolfgang
  # BluezDeviceListener
  class BluezDeviceListener < BaseSignalListener
    include Singleton
    include InterfaceConstants
    include SignalDelegator

    PROG = 'DeviceListener'

    def prog
      PROG
    end

    def logger
      LogActually.object_device
    end

    # @override PropertiesListener.properties_changed
    def properties_changed(signal)
      logger.debug(PROG) { "#properties_changed" }
      super(signal, 'Device#PropertiesChanged')
      delegate(:properties_changed, signal)
    rescue Yabber::IfYouWantSomethingDone
      logger.warn(PROG) { 'Chain did not handle!' }
    end

    # @override Callable.interface_called
    def interface_called(event)
      logger.debug(PROG) { "#interface_called(#{event})" }
      self.proc = 'Device#InterfaceCalled'
      delegate(:interface_called, event)
    rescue Yabber::IfYouWantSomethingDone
      logger.warn(PROG) { 'Chain did not handle!' }
    end

    # Called by BluezServiceListener when initialized
    def new_device(device)
      logger.info(PROG) { "New Device! #{device.path_suffix}" }
      logger.debug(PROG) { "New device class => #{device.class}" }

      properties_changed_signal_registration(device)
      interface_called_signal_registration(device)

      fetch_current_device_state(device)
    end

    private

    def properties_changed_signal_registration(device)
      logger.debug(PROG) { 'Signal Registration: :properties_changed.' }
      device.properties.listen(
        :properties_changed,
        BluezDeviceListener.instance,
        method: :properties_changed,
        klass: DevicePropertiesChanged
      )
    end

    def interface_called_signal_registration(device)
      logger.debug(PROG) { 'Signal Registration: :interface_called.' }
      device.device.interface_called(
        BluezDeviceListener.instance,
        :interface_called
      )
    end

    public

    def fetch_current_device_state(device)
      logger.debug(PROG) { "#fetch_current_device_state(#{device})" }
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
