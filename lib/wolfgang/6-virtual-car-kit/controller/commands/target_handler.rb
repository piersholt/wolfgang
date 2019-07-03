# frozen_string_literal: true

module Wolfgang
  # TargetHandler
  # TODO: MediaCommandHandler
  class TargetHandler
    include Singleton
    include NotificationDelegate
    include Messaging::Constants

    PROG = 'Controller::TargetHandler'

    attr_accessor :target

    def take_responsibility(command)
      logger.debug(PROG) { "#take_responsibility(#{command})" }
      case command.name
      when PLAYER
        player(command)
      when VOLUME_UP
        volume_up(command)
      when VOLUME_DOWN
        volume_down(command)
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
      name = target.addressed_player ? :addressed_player : :player_removed
      payload = name == :addressed_player ? target.addressed_player.attributes : {}
      r = Messaging::Reply.new(topic: TARGET, name: name, properties: payload)
      result = Server.instance.send(r.to_yaml)
      logger.debug(PROG) { "send(#{r}) => #{result}" }
    end

    SINK_ID = 0
    VOLUME_MAX = 65_536
    VOLUME_INTERVALS = 16
    VOLUME_INTERVAL = VOLUME_MAX / VOLUME_INTERVALS
    VOLUME_INCREASE = "pactl set-sink-volume #{SINK_ID} +#{VOLUME_INTERVAL}"
    VOLUME_DECREASE = "pactl set-sink-volume #{SINK_ID} -#{VOLUME_INTERVAL}"

    def volume_up(command)
      logger.info(PROG) { VOLUME_UP }
      logger.debug(PROG) { VOLUME_INCREASE }
      `#{VOLUME_INCREASE}`
    end

    def volume_down(command)
      logger.info(PROG) { VOLUME_DOWN }
      logger.debug(PROG) { VOLUME_DECREASE }
      `#{VOLUME_DECREASE}`
    end
  end
end
