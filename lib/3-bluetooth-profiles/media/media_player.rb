# frozen_string_literal: true

class MediaPlayer
  include BluezDBusInterface

  def initialize
    @manager = BluezManager.new
  end

  def start
    setup_object_handlers
    setup_device_handlers
    setup_player_handlers
    setup_notification_handlers
    signals({})
    run
    binding.pry
  end

  private

  def setup_object_handlers
    primary = configure_object_delegates
    root_listener = BluezRootListener.instance
    root_listener.declare_primary_delegate(primary)
  end

  def setup_player_handlers
    primary = configure_player_delegates
    player_listener = BluezPlayerListener.instance
    player_listener.declare_primary_delegate(primary)
  end

  def setup_device_handlers
    primary = configure_device_delegates
    device_listener = BluezDeviceListener.instance
    device_listener.declare_primary_delegate(primary)
  end

  def setup_notification_handlers
    primary = configure_notification_delegates
    notification_listener = NotificationListener.instance
    notification_listener.declare_primary_delegate(primary)
    notification_listener.listen(mq)
  end

  def configure_object_delegates
    player_handler    = PlayerObjectHandler.instance
    browser_handler   = BrowserObjectHandler.instance
    transport_handler = TransportObjectHandler.instance

    player_handler.successor  = browser_handler
    browser_handler.successor = transport_handler

    player_handler
  end

  def configure_device_delegates
    media_control_handler = MediaControlInterfaceHandler.instance
    device_handler        = DeviceInterfaceHandler.instance

    media_control_handler.mq = mq
    device_handler.mq        = mq

    media_control_handler.successor = device_handler

    media_control_handler
  end

  def configure_player_delegates
    media_player_handler = MediaPlayerInterfaceHandler.instance

    media_player_handler.mq = mq

    media_player_handler
  end

  def configure_notification_delegates
    media_handler  = MediaNotificationHandler.instance
    device_handler = DeviceNotificationHandler.instance

    media_handler.successor = device_handler

    media_handler
  end

  def m
    @manager
  end

  def mq
    @notification_bus ||= Queue.new
  end
end
