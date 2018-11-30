# frozen_string_literal: true

# Comment
class NotificationHandler
  include Singleton

  def oi(notification)
    case notification.type
    when :player_added
      player_added(notification)
    when :player_removed
      player_removed(notification)
    when :track_change
      track_change(notification)
    when :device_connected
      device_connected(notification)
    when :device_disconnected
      device_disconnected(notification)
    end
  end

  private

  def player_added(notification)
    LOGGER.fatal(self.class) { notification.inspect }
    Player.add(notification.options[:path])
  end

  def player_removed(notification)
    LOGGER.fatal(self.class) { notification.inspect }
    Player.remove
  end

  def track_change(notification)
    LOGGER.fatal(self.class) { notification.inspect }
    Player.instance.update(notification.options[:delta])
  end

  def device_connected(notification)
  end

  def device_disconnected(notification)
  end
end
