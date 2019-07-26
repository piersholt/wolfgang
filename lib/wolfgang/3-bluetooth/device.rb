# frozen_string_literal: true

puts "\tLoading wolfgang/bluetooth/device"

LogActually.is_all_around(:bt_device)
LogActually.bt_device.d

require_relative 'device/constants'
require_relative 'device/actions'
require_relative 'device/notifications'
require_relative 'device/signals'

module Wolfgang
  module Bluetooth
    # Bluetooth API: Devices
    class Device
      include Singleton

      include BluezDBusInterface
      include InterfaceConstants

      include Constants
      include Signals
      include Notifications
      include Actions

      def initialize
        setup_device_object_handlers
      end

      def object(path)
        logger.debug(PROG) { "#object(#{path}), block: #{block_given?}" }
        service.device_object(path)&.device&.property_get_all do |_, properties|
          logger.debug(PROG) { "property_get_all -> block_given? => #{block_given?}" }
          yield(path, properties) if block_given?
          properties
        end
      end

      def objects
        logger.debug(PROG) { '#objects' }
        service.device_paths do |path|
          logger.info(PROG) { "device path => #{path}" }
          service.device_object(path)&.device&.property_get_all do |_, properties|
            logger.debug(PROG) { "property_get_all -> block_given? => #{block_given?}" }
            yield(path, properties) if block_given?
            properties
          end
        end
      end

      # def state
      #   logger.debug(PROG) { '#state' }
      #   service.device_paths do |path|
      #     # logger.info(PROG) { "device path => #{path}" }
      #     service.device_object(path)&.device&.property_get_all do |_, properties|
      #       # logger.debug(PROG) { "property_get_all -> block_given? => #{block_given?}" }
      #       device_properties_changed(
      #         DevicePropertiesChanged.new(path, BLUEZ_DEVICE, properties, [])
      #       )
      #     end
      #   end
      # end

      def device_references
        @device_references ||= {}
      end

      private

      def setup_device_object_handlers
        logger.debug(PROG) { '#setup_device_object_handlers' }
        device_listener = BluezDeviceListener.instance
        device_listener.declare_primary_delegate(configure_device_object_delegates)
      end

      # setup_device_object_handlers ->
      def configure_device_object_delegates
        logger.debug(PROG) { '#configure_device_object_delegates' }
        device_handler = DeviceInterfaceHandler.instance

        device_handler.signal_callback = device_properties_changed_block
        device_handler.call_callback = device_interface_called_block

        device_handler
      end
    end
  end
end
