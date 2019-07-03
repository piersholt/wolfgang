# frozen_string_literal: true

module Wolfgang
  # DeviceHandler
  class DeviceHandler
    include Singleton
    include NotificationDelegate
    include Messaging::Constants

    attr_accessor :manager

    def responsibility
      DEVICE
    end

    def take_responsibility(command)
      logger.debug(self.class) { "#take_responsibility(#{command})" }
      case command.name
      when CONNECT
        connect(command.properties)
      when DISCONNECT
        disconnect(command.properties)
      when DEVICES
        devices
      else
        not_handled(command)
      end
    rescue StandardError => e
      logger.error(self.class) { e }
      e.backtrace.each { |l| logger.error(l) }
    end

    def logger
      LogActually.commands
    end

    def connect(address:)
      logger.info(self.class) { "#{CONNECT}: #{address}" }
      manager.connect(address)
    end

    def disconnect(address:)
      logger.info(self.class) { "#{DISCONNECT}: #{address}" }
      manager.disconnect(address)
    end

    def devices
      logger.info(self.class) { DEVICES }

      payload = manager.devices.map do |_, device_object|
        device_object.attributes
      end

      logger.debug(self.class) { "payload.size => #{payload.size}" }
      reply = Messaging::Reply.new(topic: DEVICE, name: DEVICES, properties: payload)
      result = Server.instance.send(reply.to_yaml)
      logger.debug(self.class) { "send(#{reply}) => #{result}" }
    end
  end
end
