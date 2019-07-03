# frozen_string_literal: true

module Wolfgang
  # TargetHandler
  # TODO: MediaCommandHandler
  class TargetHandler
    include Singleton
    include NotificationDelegate
    include Messaging::Constants

    attr_accessor :target

    def take_responsibility(command)
      logger.debug(self.class) { "#take_responsibility(#{command})" }
      case command.name
      when PLAYER
        player(command)
      when VOLUME_UP
        volume_up(command)
      when VOLUME_DOWN
        volume_down(command)
      end
    rescue StandardError => e
      logger.error(self.class) { e }
      e.backtrace.each { |l| logger.error(l) }
    end

    def logger
      LogActually.commands
    end

    def responsibility
      TARGET
    end

    # def everyone(command)
    #   logger.info(self.class) { EVERYONE }
    #   logger.debug(self.class) { command }
    #   target.everyone!
    # end

    def player(command)
      logger.info(self.class) { PLAYER }
      name = target.addressed_player ? :addressed_player : :player_removed
      payload = name == :addressed_player ? target.addressed_player.attributes : {}
      r = Messaging::Reply.new(topic: TARGET, name: name, properties: payload)
      result = Server.instance.send(r.to_yaml)
      logger.debug(self.class) { "send(#{r}) => #{result}" }
    end

    SINK_ID = 0
    VOLUME_MAX = 65_536
    VOLUME_INTERVALS = 16
    VOLUME_INTERVAL = VOLUME_MAX / VOLUME_INTERVALS

    def volume_up(command)
      logger.info(self.class) { VOLUME_UP }
      logger.debug(self.class) { command }
      command = "pactl set-sink-volume #{SINK_ID} +#{VOLUME_INTERVAL}"
      logger.debug(self.class) { command }
      result = `#{command}`
      logger.debug(self.class) { result }
    end

    def volume_down(command)
      logger.info(self.class) { VOLUME_DOWN }
      logger.debug(self.class) { command }
      command = "pactl set-sink-volume #{SINK_ID} -#{VOLUME_INTERVAL}"
      logger.debug(self.class) { command }
      result = `#{command}`
      logger.debug(self.class) { result }
    end
  end
end
