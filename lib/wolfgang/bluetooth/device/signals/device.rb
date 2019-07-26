# frozen_string_literal: true

module Wolfgang
  module Bluetooth
    class Device
      module Signals
        # Device::Signals::Properties
        module Device
          include LogActually::ErrorOutput
          include Constants

          # org.freedesktop.DBus.Properties.PropertiesChanged
          def device_properties_changed_block
            proc do |signal|
              device_properties_changed(signal)
            end
          end

          def device_properties_changed(signal)
            logger.debug(MODULE_PROG) do
              "#device_properties_changed(#{signal.path})"
            end

            device_references.merge!(signal.path => service.device_object(signal.path))

            case evaluate_device_properties(signal)
            when :connected
              device_connected(signal)
            when :disconnected
              device_disconnected(signal)
            end
          rescue StandardError => e
            with_backtrace(logger, e)
          end

          def evaluate_device_properties(signal)
            if signal.only?(PROPERTY_CONNECTED) && signal.connected?
              :connected
            elsif signal.only?(PROPERTY_CONNECTED) && signal.disconnected?
              :disconnected
            elsif signal.connected?
              :connected
            elsif signal.disconnected?
              :disconnected
            end
          end

          private

          def device_connected(signal)
            logger.debug(MODULE_PROG) { DEVICE_CONNECTED }
            device_connected!(signal)
          end

          def device_disconnected(signal)
            logger.debug(MODULE_PROG) { DEVICE_DISCONNECTED }
            device_disconnected!(signal)
          end
        end
      end
    end
  end
end
