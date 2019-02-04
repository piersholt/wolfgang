# frozen_string_literal: true

# Comment
# TODO: MediaCommandHandler
class WilhelmHandler
  include Singleton
  include NotificationDelegate
  include Messaging::Constants

  # attr_accessor :target

  def take_responsibility(command)
    logger.debug(self.class) { "#take_responsibility(#{command})" }
    case command.name
    when HELLO
      hello(command)
    when PING
      pong(command)
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
    n = Messaging::Reply.new(topic: WOLFGANG, name: PONG)
    # notifications_queue.push(n)
    result = Server.instance.send(n.to_yaml)
    logger.debug(self.class) { "send(#{n}) => #{result}" }
  end
end
