# frozen_string_literal: true

module Wolfgang
  # TargetNotificationHandler
  class TargetNotificationHandler
    include Singleton
    include Yabber::NotificationDelegate
    include Yabber::NotificationsRelay
    include Yabber::Constants

    def responsibility
      :target
    end

    def logger
      LogActually.bt_ct
    end

    def take_responsibility(notification)
      notification.topic = TARGET
      relay(notification)
    end
  end
end
