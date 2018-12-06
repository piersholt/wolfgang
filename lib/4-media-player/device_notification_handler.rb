# frozen_string_literal: true

# Comment
class DeviceNotificationHandler
  include Singleton
  include NotificationHandler

  ASSOCIATED_TOPIC = :device

  def take_responsibility(notification)
    case notification.name
    when :device_connected
      device_connected(notification)
    when :device_disconnected
      device_disconnected(notification)
    when :device_connecting
      device_connecting(notification)
    when :device_disconnecting
      device_disconnecting(notification)
    end
  end

  private

  def device_connected(notification)
    LOGGER.unknown(self.class) { notification.inspect }
  end

  def device_disconnected(notification)
    LOGGER.unknown(self.class) { notification.inspect }
  end

  def device_connecting(notification)
    LOGGER.unknown(self.class) { notification.inspect }
  end

  def device_disconnecting(notification)
    LOGGER.unknown(self.class) { notification.inspect }
  end

  def responsibility
    ASSOCIATED_TOPIC
  end
end
