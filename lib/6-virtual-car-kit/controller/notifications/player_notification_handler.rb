# frozen_string_literal: true

# Comment
class PlayerNotificationHandler
  include Singleton
  include NotificationDelegate
  include NotificationsRelay

  def responsibility
    :player
  end

  def take_responsibility(notification)
    relay(notification)
  end
end
