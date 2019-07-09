# frozen_string_literal: true

module Wolfgang
  # DeviceHandler
  class DeviceHandler
    include Singleton
    include Yabber::NotificationDelegate
    include Yabber::Constants

    attr_accessor :manager

    PROG = 'Manager::DeviceHandler'

    def responsibility
      DEVICE
    end

    def take_responsibility(command)
      logger.debug(PROG) { "#take_responsibility(#{command})" }
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
      logger.error(PROG) { e }
      e.backtrace.each { |l| logger.error(l) }
    end

    def logger
      LogActually.commands
    end

    def connect(address:)
      logger.info(PROG) { "#{CONNECT}: #{address}" }
      manager.connect(address)
    end

    def disconnect(address:)
      logger.info(PROG) { "#{DISCONNECT}: #{address}" }
      manager.disconnect(address)
    end

    def devices
      logger.info(PROG) { DEVICES }

      payload = manager.devices.map do |_, device_object|
        device_object.attributes
      end

      logger.debug(PROG) { "payload.size => #{payload.size}" }
      reply = Yabber::Reply.new(topic: DEVICE, name: DEVICES, properties: payload)
      result = Server.instance.send(reply.to_yaml)
      logger.debug(PROG) { "send(#{reply}) => #{result}" }
    end
  end
end
