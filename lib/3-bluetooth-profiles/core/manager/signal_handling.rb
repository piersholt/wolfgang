# frozen_string_literal: true

module Core
  # Comment
  class Manager
    # Comment
    module SignalHandling
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

      def device_called_block
        proc do |signal|
          begin
            interface_called(signal)
          rescue StandardError => e
            logger.error(self.class) { e }
            e.backtrace.each { |line| logger.error(line) }
          end
        end
      end

      # --------------------------------------------------------------------- #

      def create_or_update_device(signal)
        device_path = signal.path
        case devices.key?(device_path)
        when true
          devices[device_path].attributes!(signal.changed)
        when false
          new_device = Core::Device.new(device_path)
          new_device.attributes!(signal.changed)
          devices[device_path] = new_device
          # d = Core::Device.new("/org/bluez/hci1/dev_70_70_0D_11_CF_29")
        end
      rescue StandardError => e
        with_backtrace(logger, e)
      end

      def device_properties_changed(signal)
        logger.debug(self.class) { "device_properties_changed! #{signal.path}" }
        create_or_update_device(signal)
        # logger.unknown("i'm getting weird bug here. self.class => #{self.class}")

        if signal.only?('Connected') && signal.connected?
          device_connected
        elsif signal.only?('Connected') && signal.disconnected?
          device_disconnected
        elsif signal.connected?
          # LogActually.device.debug(self.class.name) { '' }
          device_connected
        elsif signal.disconnected?
          # LogActually.device.debug(self.class.name) { 'existing disconnected!' }
          # device_disconnected
        end
      rescue StandardError => e
        with_backtrace(logger, e)
      end

      def interface_called(event)
        logger.debug(self.class) { 'interface_called!' }
        if event.method == :connect
          device_connecting
        elsif event.method == :disconnect
          device_disconnecting
        end
      end

      def device_connecting
        logger.debug(self.class) { '#connect: Device connecting...' }
        device_connecting!
      end

      def device_disconnecting
        logger.debug(self.class) { '#disconnect: Device disconnecting...' }
        device_disconnecting!
      end

      def device_connected
        logger.debug(self.class) { 'Device connected!' }
        device_connected!
      end

      def device_disconnected
        logger.debug(self.class) { 'Device disconnected!' }
        device_disconnected!
      end
    end
  end
end
