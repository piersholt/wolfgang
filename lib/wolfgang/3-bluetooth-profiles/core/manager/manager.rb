# frozen_string_literal: true

module Wolfgang
  module Core
    # Manager
    class Manager
      # extend Forwardable
      # include State
      # include Attributes
      include SignalHandling
      include Notifications
      # include Commands
      include LogActually::ErrorOutput

      # def_delegators :object, *BluezDevice::Methods.instance_methods

      # attr_reader :object

      def logger
        LogActually.core
      end

      def devices
        @devices ||= {}
      end

      def connect(device_address)
        logger.debug(self.class.name) { "#connect(#{device_address})" }
        target_device = find_by(:address, device_address)
        logger.debug(self.class.name) { "Cannot find device to connect!" } unless target_device
        return false unless target_device
        target_device.connect
        device_connecting!(target_device)
        logger.debug(self.class.name) { "#connect returning...." }
      end

      def disconnect(device_address)
        logger.debug(self.class.name) { "#disconnect(#{device_address})" }
        target_device = find_by(:address, device_address)
        logger.debug(self.class.name) { "Cannot find device to disconnect!" } unless target_device
        return false unless target_device
        target_device.disconnect
        device_disconnecting!(target_device)
        logger.debug(self.class.name) { "#disconnect returning...." }
      end

      def find_by(property, value)
        logger.debug(self.class.name) { "#find_by(#{property}, #{value})" }
        found_device = devices.find do |_, device|
          device.public_send(property) == value
        end
        logger.debug(self.class.name) { "#find_by => #{found_device}" }
        return false unless found_device
        found_device[1]
      end

      def device(nickname)
        found_device = devices.find do |_, device|
          if device.alias == nickname
            true
          elsif nickname.is_a?(Symbol) && device.alias == nickname.to_s
            true
          elsif nickname.is_a?(Symbol) && device.alias.downcase == nickname.downcase.to_s
            true
          elsif device.address == nickname
            true
          else
            false
          end
        end
        return false unless found_device
        found_device[1]
      end

      alias d device

      # def initialize
      #   @connected = nil
      # end

      # def initialize(player_path)
      #   @object = BluezDBus.service.player(player_path)
      # end
    end
  end
end
