# frozen_string_literal: true

module Wolfgang
  # MediaHandler
  # TODO: MediaCommandHandler
  class MediaHandler
    include Singleton
    include Yabber::NotificationDelegate
    include Yabber::Constants

    PROG = 'Controller::MediaHandler'

    attr_accessor :target

    def take_responsibility(command)
      logger.debug(PROG) { "#take_responsibility(#{command})" }
      case command.name
      when PLAY
        play(command)
      when PAUSE
        pause(command)
      when STOP
        stop(command)
      when SEEK_NEXT
        seek_next(command)
      when SEEK_PREVIOUS
        seek_previous(command)
      when SCAN_FORWARD_START
        fast_forward(command)
      when SCAN_FORWARD_STOP
        play(command)
      when SCAN_BACKWARD_START
        rewind(command)
      when SCAN_BACKWARD_STOP
        play(command)
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

    def play(command)
      logger.info(PROG) { PLAY }
      logger.debug(PROG) { command }
      target.play
    end

    def pause(command)
      logger.info(PROG) { PAUSE }
      logger.debug(PROG) { command }
      target.pause
    end

    def stop(command)
      logger.info(PROG) { STOP }
      logger.debug(PROG) { command }
      target.stop
    end

    def seek_next(command)
      logger.info(PROG) { SEEK_NEXT }
      logger.debug(PROG) { command }
      target.next
    end

    def seek_previous(command)
      logger.info(PROG) { SEEK_PREVIOUS }
      logger.debug(PROG) { command }
      target.previous
    end

    def fast_forward(command)
      logger.info(PROG) { SCAN_FORWARD_START }
      logger.debug(PROG) { command }
      target.fast_forward
    end

    def rewind(command)
      logger.info(PROG) { SCAN_BACKWARD_START }
      logger.debug(PROG) { command }
      target.rewind
    end
  end
end
