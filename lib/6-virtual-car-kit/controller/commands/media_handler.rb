# frozen_string_literal: true

# Comment
# TODO: MediaCommandHandler
class MediaHandler
  include Singleton
  include NotificationDelegate
  include Messaging::Constants

  attr_accessor :target

  def take_responsibility(command)
    logger.debug(self.class) { "#take_responsibility(#{command})" }
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
    logger.error(self.class) { e }
    e.backtrace.each { |l| logger.error(l) }
  end

  def logger
    LogActually.commands
  end

  def responsibility
    PLAYER
  end

  def play(command)
    logger.info(self.class) { PLAY }
    logger.debug(self.class) { command }
    target.play
  end

  def pause(command)
    logger.info(self.class) { PAUSE }
    logger.debug(self.class) { command }
    target.pause
  end

  def stop(command)
    logger.info(self.class) { STOP }
    logger.debug(self.class) { command }
    target.stop
  end

  def seek_next(command)
    logger.info(self.class) { SEEK_NEXT }
    logger.debug(self.class) { command }
    target.next
  end

  def seek_previous(command)
    logger.info(self.class) { SEEK_PREVIOUS }
    logger.debug(self.class) { command }
    target.previous
  end

  def fast_forward(command)
    logger.info(self.class) { SCAN_FORWARD_START }
    logger.debug(self.class) { command }
    target.fast_forward
  end

  def rewind(command)
    logger.info(self.class) { SCAN_BACKWARD_START }
    logger.debug(self.class) { command }
    target.rewind
  end
end
