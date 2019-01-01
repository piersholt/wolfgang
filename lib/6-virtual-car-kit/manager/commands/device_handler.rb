# frozen_string_literal: true

# Comment
class DeviceHandler
  include Singleton
  include NotificationDelegate
  include Messaging::Constants

  attr_accessor :manager

  def take_responsibility(command)
    logger.debug(self.class) { "#take_responsibility(#{command})" }
    case command.name
    when CONNECT
      connect()
    when DISCONNECT
      disconnect()
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

  def connect
    logger.info(self.class) { CONNECT }
    # manager.connect
  end

  def disconnect
    logger.info(self.class) { DISCONNECT }
    # manager.disconnect
  end

  def responsibility
    DEVICE
  end
end
