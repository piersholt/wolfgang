# frozen_string_literal: true

# Comment
class PlayerNotificationHandler
  include Singleton
  include NotificationDelegate
  include NotificationsRelay
  include Messaging::Constants

  def responsibility
    :player
  end

  def logger
    LogActually.media_player
  end

  def take_responsibility(notification)
    notification.topic = PLAYER
    relay(notification)
  end
end
