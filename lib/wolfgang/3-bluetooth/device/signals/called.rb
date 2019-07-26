# frozen_string_literal: true

module Wolfgang
  module Bluetooth
    class Device
      module Signals
        # Device::Signals::Called
        # The :connecting and :disconnecting notifications are used to update
        # the UI state. As to make the UI as responsible as possible,
        # Core::Manager will send the notifications when #connect or
        # #disconnect is called rather than waiting for the InterfaceCalled
        # signal.
        module Called
          include LogActually::ErrorOutput
          include Constants

          # Wolfgang::Callable.interface_called
          def device_interface_called_block
            proc do |signal|
              device_interface_called(signal)
            end
          end

          def device_interface_called(interface_called_signal)
            logger.debug(MODULE_PROG) do
              "#device_interface_called(#{interface_called_signal})"
            end
            if interface_called_signal.method == PROPERTY_CONNECT
              device_connecting
            elsif interface_called_signal.method == PROPERTY_DISCONNECT
              device_disconnecting
            end
          rescue StandardError => e
            with_backtrace(logger, e)
          end

          def device_connecting
            logger.debug(MODULE_PROG) { DEVICE_CONNECT_CALLED }
          end

          def device_disconnecting
            logger.debug(MODULE_PROG) { DEVICE_DISCONNECT_CALLED }
          end
        end
      end
    end
  end
end
