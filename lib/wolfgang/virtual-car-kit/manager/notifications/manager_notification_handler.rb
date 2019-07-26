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
      LogActually.bt_device
    end

    def take_responsibility(notification)
      notification.topic = DEVICE
      case notification.type
      when Types::NOTIFICATION
        relay(notification)
      when Types::ACTION
        false
        # raise TypeError, 'ACTION cannot be forwarded!'
      when Types::REQUEST
        false
        # raise TypeError, 'REQUEST cannot be forwarded!'
      when Types::REPLY
        false
        # raise TypeError, 'REPLY cannot be forwarded!'
      end
    end
  end
end
