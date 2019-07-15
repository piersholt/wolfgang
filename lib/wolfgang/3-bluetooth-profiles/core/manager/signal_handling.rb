# frozen_string_literal: true

module Wolfgang
  module Core
    class Manager
      # SignalHandling
      module SignalHandling
        # org.freedesktop.DBus.Properties.PropertiesChanged
        def device_properties_changed_block
          proc do |signal|
            begin
              device_properties_changed(signal)
            rescue StandardError => e
              logger.error(self.class) { e }
              e.backtrace.each { |line| logger.error(line) }
            end
          end
        end

        # Wolfgang::Callable.interface_called
        def device_interface_called_block
          proc do |signal|
            begin
              device_interface_called(signal)
            rescue StandardError => e
              logger.error(self.class) { e }
              e.backtrace.each { |line| logger.error(line) }
            end
          end
        end

        # DEVICE_PROPERTIES_CHANGED_BLOCK -------------------------------------

        def device_properties_changed(signal)
          logger.debug(self.class) { "device_properties_changed! #{signal.path}" }
          device_in_question = create_or_update_device(signal)

          if signal.only?(:connected) && signal.connected?
            device_connected(device_in_question)
          elsif signal.only?(:connected) && signal.disconnected?
            device_disconnected(device_in_question)
          elsif signal.connected?
            device_connected(device_in_question)
          elsif signal.disconnected?
            device_disconnected(device_in_question)
          end
        rescue StandardError => e
          with_backtrace(logger, e)
        end

        def create_or_update_device(signal)
          device_path = signal.path
          case devices.key?(device_path)
          when true
            devices[device_path].attributes!(signal.changed)
            devices[device_path]
          when false
            new_device = Core::Device.new(device_path)
            new_device.attributes!(signal.changed)
            devices[device_path] = new_device
            devices[device_path]
          end
        rescue StandardError => e
          with_backtrace(logger, e)
        end

        def device_connected(device_in_question)
          logger.debug(self.class) { 'Device connected!' }
          device_connected!(device_in_question)
        end

        def device_disconnected(device_in_question)
          logger.debug(self.class) { 'Device disconnected!' }
          device_disconnected!(device_in_question)
        end

        # DEVICE_INTERFACE_CALLED_BLOCK ---------------------------------------

        # The :connecting and :disconnecting notifications are used to update
        # the UI state. As to make the UI as responsible as possible,
        # Core::Manager will send the notifications when #connect or
        # #disconnect is called rather than waiting for the InterfaceCalled
        # signal.

        def device_interface_called(interface_called_signal)
          logger.debug(self.class) do
            "#device_interface_called: (#{interface_called_signal})"
          end
          if interface_called_signal.method == :connect
            device_connecting
          elsif interface_called_signal.method == :disconnect
            device_disconnecting
          end
        end

        def device_connecting
          logger.warn(self.class) do
            '[DISABLED] Called! BluezDevice[Interface].connect()'
          end
          # properties = find_by(:address, address) || {}
          # device_connecting!(properties)
        end

        def device_disconnecting
          logger.warn(self.class) do
            '[DISABLED] Called! BluezDevice[Interface].disconnect()'
          end
          # properties = find_by(:address, address) || {}
          # device_disconnecting!(properties)
        end
      end
    end
  end
end
