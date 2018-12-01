# frozen_string_literal: true

# Comment
class DeviceNotificationHandler
  include Singleton
  include NotificationHandler

  ASSOCIATED_TYPE = :device

  def take_responsibility(notification)
    case notification.name
    when :device_connected
      device_connected(notification)
    when :device_disconnected
      device_disconnected(notification)
    end
  end

  private

  def device_connected(notification)
    LOGGER.fatal(self.class) { notification.inspect }
  end

  def device_disconnected(notification)
    LOGGER.fatal(self.class) { notification.inspect }
  end

  def responsibility
    ASSOCIATED_TYPE
  end
end
