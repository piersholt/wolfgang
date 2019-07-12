# frozen_string_literal: true

module Wolfgang
  # TargetHandler
  class TargetHandler
    include Singleton
    include Yabber::NotificationDelegate
    include Yabber::Constants

    PROG = 'Controller::TargetHandler'
    ERROR_PLAYER = 'No attributes for addressed player you muppet!'

    attr_accessor :target

    def take_responsibility(command)
      logger.debug(PROG) { "#take_responsibility(#{command})" }
      case command.name
      when PLAYER
        player(command)
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

    # Request Player object
    def player(*)
      logger.info(PROG) { PLAYER }
      if target.addressed_player.nil?
        reply = Yabber::Reply.new(
          topic: TARGET,
          name: :player_removed,
          properties: {}
        )
      else
        addressed_player = target.addressed_player
        raise(ArgumentError, ERROR_PLAYER) unless addressed_player
        device = addressed_player.device
        reply = Yabber::Reply.new(
          topic: TARGET,
          name: :player_changed,
          properties: { device: device, properties: target.attributes }
        )
      end
      Yabber::Server.instance.send(reply.to_yaml)
    end
  end
end
