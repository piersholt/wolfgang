# frozen_string_literal: true

# Comment
class TargetNotificationHandler
  include Singleton
  include NotificationDelegate
  include NotificationsRelay
  include Messaging::Constants

  def responsibility
    :target
  end

  def logger
    LogActually.avrcp
  end

  def take_responsibility(notification)
    notification.topic = CONTROLLER
    relay(notification)
  end
end
