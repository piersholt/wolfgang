# frozen_string_literal: true

module Wolfgang
  # TargetHandler
  class TargetHandler
    include Singleton

    include Yabber::NotificationDelegate
    include Yabber::Constants

    include InterfaceConstants

    PROG = 'Controller::TargetHandler'
    ERROR_PLAYER = 'No attributes for addressed player you muppet!'

    attr_accessor :controller, :device

    def take_responsibility(command)
      logger.debug(PROG) { "#take_responsibility(#{command})" }
      case command.name
      when PLAYER
        player(command.properties)
      when TARGET
        all_targets
      end
    rescue StandardError => e
      logger.error(PROG) { e }
      e.backtrace.each { |l| logger.error(l) }
    end

    def logger
      LogActually.commands
    end

    def responsibility
      TARGET
    end

    def no_player(path)
      logger.unknown(PROG) { "#no_player(#{path})" }
      reply =
        Yabber::Reply.new(
          topic: TARGET,
          name: :addressed_player,
          properties: { path => false }
        )
      logger.unknown(PROG) { "reply = #{reply}" }
      Yabber::Server.send_message(reply.to_yaml)
    end

    def all_targets
      logger.info(PROG) { '#all_targets' }

      callback_queue = Queue.new

      controller.targets do |device_path, device_properties|
        logger.unknown(PROG) { "D-BUS Thread #{Thread.current}" }
        # logger.unknown(PROG) { "device_properties => #{device_properties}" }
        # logger.unknown(PROG) { "Hashify.symbolize(device_properties) => #{symbolized_props}" }
        signal = DevicePropertiesChanged.new(device_path, BLUEZ_MEDIA_CONTROL, device_properties, [])
        event = controller.evaluate_media_control_properties(signal)

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
        name: TARGET,
        properties: device_hash
      )
      Yabber::Server.send_message(reply.to_yaml)
    end

    # Request Player object
    def player(path:)
      logger.info(PROG) { PLAYER }

      callback_queue = Queue.new

      controller.player(path)  do |player_path, player_properties|
        logger.unknown(PROG) { "D-BUS Thread #{Thread.current}" }
        logger.unknown(PROG) { "player_properties => #{player_properties}" }
        symbolized_props = Hashify.symbolize(player_properties)
        logger.unknown(PROG) { "Hashify.symbolize(player_properties) => #{symbolized_props}" }

        callback_queue.push(
          { path: player_path }.merge(symbolized_props)
        )
      end

      properties_hash = callback_queue.pop
      logger.unknown(PROG) { "Handler Thread: #{Thread.current}" }
      logger.unknown(PROG) { "callback_queue.pop => #{properties_hash}" }

      reply = Yabber::Reply.new(
        topic: TARGET,
        name: :addressed_player,
        properties: properties_hash
      )
      logger.unknown(PROG) { "reply = #{reply}" }
      Yabber::Server.send_message(reply.to_yaml)
    end
  end
end
