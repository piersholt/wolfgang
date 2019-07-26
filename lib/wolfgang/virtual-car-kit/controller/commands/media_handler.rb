# frozen_string_literal: true

module Wolfgang
  # MediaHandler
  # TODO: MediaCommandHandler
  class MediaHandler
    include Singleton
    include Yabber::NotificationDelegate
    include Yabber::Constants

    PROG = 'Controller::MediaHandler'

    attr_accessor :controller

    def take_responsibility(command)
      logger.debug(PROG) { "#take_responsibility(#{command})" }
      case command.name
      when PLAY
        play(command.name, command.properties)
      when PAUSE
        pause(command.name, command.properties)
      when STOP
        stop(command.name, command.properties)
      when SEEK_NEXT
        seek_next(command.name, command.properties)
      when SEEK_PREVIOUS
        seek_previous(command.name, command.properties)
      when SCAN_FORWARD_START
        fast_forward(command.name, command.properties)
      when SCAN_FORWARD_STOP
        play(command.name, command.properties)
      when SCAN_BACKWARD_START
        rewind(command.name, command.properties)
      when SCAN_BACKWARD_STOP
        play(command.name, command.properties)
      end
    rescue StandardError => e
      logger.error(PROG) { e }
      e.backtrace.each { |l| logger.error(l) }
    end

    def logger
      LogActually.commands
    end

    def responsibility
      PLAYER
    end

    def play(command, path:)
      logger.info(PROG) { PLAY }
      logger.debug(PROG) { command }
      controller.route(:play, path)
    end

    def pause(command, path:)
      logger.info(PROG) { PAUSE }
      logger.debug(PROG) { command }
      controller.route(:pause, path)
    end

    def stop(command, path:)
      logger.info(PROG) { STOP }
      logger.debug(PROG) { command }
      controller.route(:stop, path)
    end

    def seek_next(command, path:)
      logger.info(PROG) { SEEK_NEXT }
      logger.debug(PROG) { command }
      controller.route(:next, path)
    end

    def seek_previous(command, path:)
      logger.info(PROG) { SEEK_PREVIOUS }
      logger.debug(PROG) { command }
      controller.route(:previous, path)
    end

    def fast_forward(command, path:)
      logger.info(PROG) { SCAN_FORWARD_START }
      logger.debug(PROG) { command }
      controller.route(:fast_forward, path)
    end

    def rewind(command, path:)
      logger.info(PROG) { SCAN_BACKWARD_START }
      logger.debug(PROG) { command }
      controller.route(:rewind, path)
    end
  end
end
