# frozen_string_literal: true

# Comment
class TargetNotificationHandler
  include Singleton
  include NotificationDelegate
  include NotificationsRelay

  def responsibility
    :target
  end

  def logger
    LogActually.avrcp
  end

  def take_responsibility(notification)
    relay(notification)
  end
end
