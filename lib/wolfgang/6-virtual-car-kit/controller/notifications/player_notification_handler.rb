# frozen_string_literal: true

module Wolfgang
  # PlayerNotificationHandler
  class PlayerNotificationHandler
    include Singleton
    include Yabber::NotificationDelegate
    include Yabber::NotificationsRelay
    include Yabber::Constants

    def responsibility
      :player
    end

    def logger
      LogActually.avrcp
    end

    def take_responsibility(notification)
      notification.topic = PLAYER
      relay(notification)
    end
  end
end
