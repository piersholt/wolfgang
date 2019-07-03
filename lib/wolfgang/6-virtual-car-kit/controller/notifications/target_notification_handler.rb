# frozen_string_literal: true

module Wolfgang
  # TargetNotificationHandler
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
      notification.topic = TARGET
      relay(notification)
    end
  end
end
