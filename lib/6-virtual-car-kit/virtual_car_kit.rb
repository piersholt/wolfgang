# frozen_string_literal: true

# Comment
class VirtualCarKit
  include BluezDBusInterface
  attr_reader :controller
  attr_reader :manager

  def initialize
    Publisher.online(:wolfgang)
    @controller = Controller.new(outgoing_notifications_queue)
    @manager = Manager.new(outgoing_notifications_queue)
    setup_outgoing_notification_handlers
    setup_incoming_command_handlers
  end

  def start
    signals({})
    run
    binding.pry
  end

  def outgoing_notifications_queue
    @outgoing_notifications_queue ||= Queue.new
  end

  def devices
    manager.manager.devices
  end

  def device(nickname)
    manager.manager.device(nickname)
  end

  # Commands

  def setup_incoming_command_handlers
    primary = setup_incoming_notification_handlers
    command_listener = CommandListener.instance
    command_listener.declare_primary_delegate(primary)
    command_listener.listen
  end

  def setup_incoming_notification_handlers
    device_handler = DeviceHandler.instance
    device_handler.manager = manager.manager

    media_handler = MediaHandler.instance
    media_handler.target = controller.target

    wilhelm_handler = WilhelmHandler.instance

    media_handler.successor = device_handler
    device_handler.successor = wilhelm_handler

    media_handler
  end

  def setup_outgoing_notification_handlers
    primary = configure_outgoing_notification_delegates
    notification_listener = NotificationListener.instance
    notification_listener.declare_primary_delegate(primary)
    notification_listener.listen(outgoing_notifications_queue)
  end

  def configure_outgoing_notification_delegates
    player_handler = PlayerNotificationHandler.instance
    target_handler = TargetNotificationHandler.instance
    manager_handler = ManagerNotificationHandler.instance

    player_handler.successor = target_handler
    target_handler.successor = manager_handler

    player_handler
  end
end
