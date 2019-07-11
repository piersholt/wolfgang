# frozen_string_literal: true

module Wolfgang
  # TargetHandler
  # TODO: MediaCommandHandler
  class TargetHandler
    include Singleton
    include Yabber::NotificationDelegate
    include Yabber::Constants

    PROG = 'Controller::TargetHandler'

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

    def player(command)
      logger.info(PROG) { PLAYER }
      if target.addressed_player.nil?
        reply = Yabber::Reply.new(topic: TARGET, name: :player_removed, properties: {})
        Yabber::Server.instance.send(reply.to_yaml)
        # logger.debug(PROG) { "send(#{reply}) => #{result}" }
      else
        payload = target.addressed_player.attributes
        raise(ArgumentError, 'No attributes for addressed player you muppet!') unless payload
        reply = Yabber::Reply.new(topic: TARGET, name: :addressed_player, properties: payload)
        Yabber::Server.instance.send(reply.to_yaml)
        # logger.debug(PROG) { "send(#{reply}) => #{result}" }
      end
    end
  end
end
