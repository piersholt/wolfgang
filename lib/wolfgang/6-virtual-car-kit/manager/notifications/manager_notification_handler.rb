# frozen_string_literal: true

module Wolfgang
  # ManagerNotificationHandler
  class ManagerNotificationHandler
    include Singleton
    include Yabber::NotificationDelegate
    include Yabber::NotificationsRelay
    include Yabber::Constants

    def responsibility
      :device
    end

    def logger
      LogActually.core
    end

    def take_responsibility(notification)
      notification.topic = DEVICE
      relay(notification)
    end
  end
end
