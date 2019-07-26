# frozen_string_literal: true

module Wolfgang
  # DeviceHandler
  class DeviceHandler
    include Singleton

    include Yabber::NotificationDelegate
    include Yabber::Constants

    include InterfaceConstants

    attr_accessor :device

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
      when DEVICE
        one_device
      when DEVICES
        all_devices
      else
        not_handled(command)
      end
    rescue StandardError => e
      logger.error(PROG) { e }
      e.backtrace.each { |l| logger.error(l) }
      false
    end

    def logger
      LogActually.commands
    end

    def connect(path:)
      logger.info(PROG) { "#{CONNECT}: #{path}" }
      device.connect(path)
    end

    def disconnect(path:)
      logger.info(PROG) { "#{DISCONNECT}: #{path}" }
      device.disconnect(path)
    end

    # @todo add support for single device as it's wired up with below
    def one_device(path:)
      logger.info(PROG) { '#one_device' }

      callback_queue = Queue.new

      device.object(path)  do |device_path, device_properties|
        logger.unknown(PROG) { "D-BUS Thread #{Thread.current}" }
        logger.unknown(PROG) { "device_properties => #{device_properties}" }
        symbolized_props = Hashify.symbolize(device_properties)
        logger.unknown(PROG) { "Hashify.symbolize(device_properties) => #{symbolized_props}" }

        callback_queue.push(
          { path: device_path }.merge(symbolized_props)
        )
      end

      properties_hash = callback_queue.pop
      logger.unknown(PROG) { "Handler Thread: #{Thread.current}" }
      logger.unknown(PROG) { "callback_queue.pop => #{properties_hash}" }

      reply = Yabber::Reply.new(
        topic: :device,
        name: DEVICE,
        properties: properties_hash
      )
      logger.unknown(PROG) { "reply = #{reply}" }
      Yabber::Server.send_message(reply.to_yaml)
    end

    def all_devices
      logger.info(PROG) { DEVICES }

      callback_queue = Queue.new

      device.objects do |device_path, device_properties|
        logger.unknown(PROG) { "D-BUS Thread #{Thread.current}" }
        # logger.unknown(PROG) { "device_properties => #{device_properties}" }
        # logger.unknown(PROG) { "Hashify.symbolize(device_properties) => #{symbolized_props}" }
        signal = DevicePropertiesChanged.new(device_path, BLUEZ_DEVICE, device_properties, [])
        event = device.evaluate_device_properties(signal)

        symbolized_props = Hashify.symbolize(device_properties)
        result = { device_path => { state: event, properties: { path: device_path }.merge(symbolized_props) } }
        callback_queue.push(result)
      end

      device_hash = {}

      2.times do
        properties_hash = callback_queue.pop
        logger.unknown(PROG) { "Handler Thread: #{Thread.current}" }
        logger.unknown(PROG) { "callback_queue.pop => #{properties_hash}" }
        device_hash.merge!(properties_hash)
      end

      reply = Yabber::Reply.new(
        topic: :device,
        name: DEVICES,
        properties: device_hash
      )
      Yabber::Server.send_message(reply.to_yaml)
    end
  end
end
