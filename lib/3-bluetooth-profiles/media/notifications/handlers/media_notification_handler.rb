# frozen_string_literal: true

# Comment
class MediaNotificationHandler
  include Singleton
  include NotificationHandler

  ASSOCIATED_TOPIC = :media

  def take_responsibility(notification)
    case notification.name
    when :player_added
      player_added(notification)
    when :player_removed
      player_removed(notification)
    when :track_change
      track_change(notification)
    when :position
      position(notification)
    when :status
      status(notification)
    when :repeat
      repeat(notification)
    when :shuffle
      shuffle(notification)
    end
  end

  private

  def player_added(notification)
    LOGGER.fatal(self.class) { notification.inspect }
    publish(notification)
    Player.add(notification.properties[:path])
  end

  def player_removed(notification)
    LOGGER.fatal(self.class) { notification.inspect }
    publish(notification)
    Player.remove
  end

  def track_change(notification)
    LOGGER.fatal(self.class) { notification.inspect }
    publish(notification)
    Player.update(notification.properties)
  end

  def position(notification)
    LOGGER.fatal(self.class) { notification.inspect }
    publish(notification)
    Player.update(notification.properties)
  end

  def status(notification)
    LOGGER.fatal(self.class) { notification.inspect }
    publish(notification)
    Player.update(notification.properties)
  end

  def repeat(notification)
    LOGGER.fatal(self.class) { notification.inspect }
    publish(notification)
    Player.update(notification.properties)
  end

  def shuffle(notification)
    LOGGER.fatal(self.class) { notification.inspect }
    publish(notification)
    Player.update(notification.properties)
  end

  def responsibility
    ASSOCIATED_TOPIC
  end
end
