# frozen_string_literal: true

class MediaPlayer
  include BluezDBusInterface

  def initialize
    @manager = BluezManager.new
  end

  def start
    @notification_bus = Queue.new
    # @notification_handler = NotificationHandler.instance
    # @command_bus = Queue.new
    setup_object_handlers
    setup_device_handlers
    setup_player_handlers
    signals({})
    # NotificationListener.handler(@notification_handler)
    device_handler = DeviceNotificationHandler.instance
    media_handler = MediaNotificationHandler.instance
    media_handler.successor = device_handler
    notification_listener = NotificationListener.instance
    notification_listener.declare_primary_delegate(media_handler)
    NotificationListener.listen(@notification_bus)
    run

    binding.pry
  end

  private

  def setup_object_handlers
    player_handler = PlayerObjectHandler.instance
    browser_handler = BrowserObjectHandler.instance
    transport_handler = TransportObjectHandler.instance

    player_handler.successor = browser_handler
    browser_handler.successor = transport_handler

    root_listener = BluezRootListener.instance
    root_listener.declare_primary_delegate(player_handler)
  end

  def setup_player_handlers
    media_player_handler = MediaPlayerInterfaceHandler.instance
    media_player_handler.mq = @notification_bus

    player_listener = BluezPlayerListener.instance
    player_listener.declare_primary_delegate(media_player_handler)
  end

  def setup_device_handlers
    media_control_handler = MediaControlInterfaceHandler.instance
    media_control_handler.mq = @notification_bus
    device_handler = DeviceInterfaceHandler.instance
    device_handler.mq = @notification_bus

    media_control_handler.successor = device_handler

    device_listener = BluezDeviceListener.instance
    device_listener.declare_primary_delegate(media_control_handler)
  end

  def m
    @manager
  end
end
