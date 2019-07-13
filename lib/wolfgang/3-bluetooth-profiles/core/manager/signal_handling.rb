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

        # ---------------------------------------------------------------------

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

        # Manager calls device_connecting! upon receiving :connect as the
        # connecting/disconnecting states are used for UI 'loading' states and
        # it would be rather counter intuitive to wait for device signal.
        def device_interface_called(*)
          logger.debug(self.class) { "#device_interface_called! (#{interface_called_signal})" }
          if interface_called_signal.method == :connect
            device_connecting
          elsif interface_called_signal.method == :disconnect
            device_disconnecting
          end
        end

        def device_connecting
          logger.debug(self.class) { "#connect: Device connecting..." }
          # properties = find_by(:address, address) || {}
          # device_connecting!(properties)
        end

        def device_disconnecting
          logger.debug(self.class) { "#disconnect: Device disconnecting..." }
          # properties = find_by(:address, address) || {}
          # device_disconnecting!(properties)
        end

        def device_connected(device_in_question)
          logger.debug(self.class) { 'Device connected!' }
          device_connected!(device_in_question)
        end

        def device_disconnected(device_in_question)
          logger.debug(self.class) { 'Device disconnected!' }
          device_disconnected!(device_in_question)
        end
      end
    end
  end
end
