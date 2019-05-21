# frozen_string_literal: true

# Comment
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
    logger.debug(self.class) { "send(#{n}) => #{result}" }
  end
end
