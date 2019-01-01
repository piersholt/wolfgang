# frozen_string_literal: true

# Comment
class ManagerNotificationHandler
  include Singleton
  include NotificationDelegate
  include NotificationsRelay

  def responsibility
    :device
  end

  def logger
    LogActually.core
  end

  def take_responsibility(notification)
    relay(notification)
    # case notification.name
    # when :player_added
    #   player_added(notification)
    # when :player_removed
    #   player_removed(notification)
    # end
  end

  # private
  #
  # def player_added(notification)
  #   LOGGER.fatal(self.class) { notification.inspect }
  #   relay(notification)
  #   # target.add_player(notification.properties[:path])
  # end
  #
  # def player_removed(notification)
  #   LOGGER.fatal(self.class) { notification.inspect }
  #   relay(notification)
  #   # target.remove_player
  # end
end
