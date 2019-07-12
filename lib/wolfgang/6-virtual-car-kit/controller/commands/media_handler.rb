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
        play(command.name, command.properties[:device])
      when PAUSE
        pause(command.name, command.properties[:device])
      when STOP
        stop(command.name, command.properties[:device])
      when SEEK_NEXT
        seek_next(command.name, command.properties[:device])
      when SEEK_PREVIOUS
        seek_previous(command.name, command.properties[:device])
      when SCAN_FORWARD_START
        fast_forward(command.name, command.properties[:device])
      when SCAN_FORWARD_STOP
        play(command.name, command.properties[:device])
      when SCAN_BACKWARD_START
        rewind(command.name, command.properties[:device])
      when SCAN_BACKWARD_STOP
        play(command.name, command.properties[:device])
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

    def play(command, device)
      logger.info(PROG) { PLAY }
      logger.debug(PROG) { command }
      target.pass(device, :play)
    end

    def pause(command, device)
      logger.info(PROG) { PAUSE }
      logger.debug(PROG) { command }
      target.pass(device, :pause)
    end

    def stop(command, device)
      logger.info(PROG) { STOP }
      logger.debug(PROG) { command }
      target.pass(device, :stop)
    end

    def seek_next(command, device)
      logger.info(PROG) { SEEK_NEXT }
      logger.debug(PROG) { command }
      target.pass(device, :next)
    end

    def seek_previous(command, device)
      logger.info(PROG) { SEEK_PREVIOUS }
      logger.debug(PROG) { command }
      target.pass(device, :previous)
    end

    def fast_forward(command, device)
      logger.info(PROG) { SCAN_FORWARD_START }
      logger.debug(PROG) { command }
      target.pass(device, :fast_forward)
    end

    def rewind(command, device)
      logger.info(PROG) { SCAN_BACKWARD_START }
      logger.debug(PROG) { command }
      target.pass(device, :rewind)
    end
  end
end
