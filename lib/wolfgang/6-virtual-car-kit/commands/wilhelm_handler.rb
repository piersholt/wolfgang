# frozen_string_literal: true

module Wolfgang
  # WolfgangHandler
  # TODO: MediaCommandHandler
  class WolfgangHandler
    include Singleton
    include Yabber::NotificationDelegate
    include Yabber::Constants

    PROG = 'Controller::WolfgangHandler'

    def take_responsibility(command)
      logger.debug(self.class) { "#take_responsibility(#{command})" }
      case command.name
      when HELLO
        hello(command)
      when PING
        pong(command)
      when VOLUME_UP
        volume_up(command)
      when VOLUME_DOWN
        volume_down(command)
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

    def responsibility
      WOLFGANG
    end

    def hello(command)
      logger.info(self.class) { HELLO }
      logger.debug(self.class) { command }
      # do_somthing
    end

    def pong(command)
      logger.info(self.class) { PONG }
      logger.debug(self.class) { command }

      reply = Yabber::Reply.new(topic: WOLFGANG, name: PONG)
      Yabber::Server.send_message(reply.to_yaml)
    end

    SINK_ID = 0
    VOLUME_MAX = 65_536
    VOLUME_INTERVALS = 16
    VOLUME_INTERVAL = VOLUME_MAX / VOLUME_INTERVALS
    VOLUME_INCREASE = "pactl set-sink-volume #{SINK_ID} +#{VOLUME_INTERVAL}"
    VOLUME_DECREASE = "pactl set-sink-volume #{SINK_ID} -#{VOLUME_INTERVAL}"

    def volume_up(*)
      logger.info(PROG) { VOLUME_UP }
      logger.debug(PROG) { VOLUME_INCREASE }
      `#{VOLUME_INCREASE}`
    end

    def volume_down(*)
      logger.info(PROG) { VOLUME_DOWN }
      logger.debug(PROG) { VOLUME_DECREASE }
      `#{VOLUME_DECREASE}`
    end
  end
end
