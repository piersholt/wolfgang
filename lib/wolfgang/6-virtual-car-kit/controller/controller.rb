# frozen_string_literal: true

class VirtualCarKit
  # Comment
  class Controller
    attr_reader :target

    def initialize(outgoing_notifications_queue)
      @target_role = AVRCP::TargetRole.new(outgoing_notifications_queue)
      # @target_role.notifications_queue =
      @target = @target_role.target
      # setup_notification_handlers
      # setup_command_handlers
    end

    def punch_it_chewie
      announce(Messaging::Constants::TARGET)
    end

    # def start
    #   CommandHandler.instance.target = @target
    # end

    # def manager
    #   @manager ||= BluezManager.new
    # end

    # alias m manager

    private

    # def notifications_queue
    #   @notifications_queue ||= Queue.new
    # end
    #
    # def setup_command_handlers
    #   command_listener = CommandListener.instance
    #   command_listener.handler = CommandHandler.instance
    #   # command_listener.listen
    # end
    #
    # def setup_notification_handlers
    #   primary = configure_notification_delegates
    #   notification_listener = NotificationListener.instance
    #   notification_listener.declare_primary_delegate(primary)
    #   # notification_listener.listen(notifications_queue)
    # end
    #
    # def configure_notification_delegates
    #   player_handler = PlayerNotificationHandler.instance
    #   target_handler = TargetNotificationHandler.instance
    #   manager_handler = ManagerNotificationHandler.instance
    #
    #   player_handler.successor = target_handler
    #   target_handler.successor = manager_handler
    #
    #   player_handler
    # end
  end
end