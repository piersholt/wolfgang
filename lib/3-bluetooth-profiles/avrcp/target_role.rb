# frozen_string_literal: true

module AVRCP
  # Comment
  class TargetRole
    include BluezDBusInterface

    attr_accessor :notifications_queue, :commands_queue

    def start
      setup_object_handlers
      setup_device_handlers
      setup_player_handlers
      # setup_notification_handlers
      signals({})
      run
      target
    end

    def t
      target
    end

    private

    # -------------------------- OBJECTS --------------------------

    def setup_object_handlers
      primary = configure_object_delegates
      root_listener = BluezRootListener.instance
      root_listener.declare_primary_delegate(primary)
    end

    def configure_object_delegates
      player_handler    = PlayerObjectHandler.instance
      browser_handler   = BrowserObjectHandler.instance
      transport_handler = TransportObjectHandler.instance

      player_handler.successor  = browser_handler
      browser_handler.successor = transport_handler

      player_handler
    end

    # -------------------------- DEVICE --------------------------

    def setup_device_handlers
      primary = configure_device_delegates
      device_listener = BluezDeviceListener.instance
      device_listener.declare_primary_delegate(primary)
    end

    def configure_device_delegates
      device_handler        = DeviceInterfaceHandler.instance
      media_control_handler = MediaControlInterfaceHandler.instance

      # device_handler.callback = target.target_callback
      media_control_handler.callback = target.target_control_callback
      device_handler.signal_callback = target.target_device_callback
      device_handler.call_callback = target.target_device_call_callback

      # device_handler.mq        = mq
      # media_control_handler.mq = mq
      # device_handler.target = target
      # media_control_handler.target = target

      device_handler.successor = media_control_handler

      device_handler
    end

    # -------------------------- PLAYER --------------------------

    def setup_player_handlers
      primary = configure_player_delegates
      player_listener = BluezPlayerListener.instance
      player_listener.declare_primary_delegate(primary)
    end

    def configure_player_delegates
      media_player_handler = MediaPlayerInterfaceHandler.instance

      # media_player_handler.mq = mq
      # media_player_handler.target = target
      media_player_handler.callback = target.player_callback

      media_player_handler
    end

    # -------------------------- NOTIFICATIONS --------------------------

    # def setup_notification_handlers
    #   primary = configure_notification_delegates
    #   notification_listener = NotificationListener.instance
    #   notification_listener.declare_primary_delegate(primary)
    #   notification_listener.listen(mq)
    # end
    #
    # def configure_notification_delegates
    #   target_handler = TargetNotificationHandler.instance
    #   player_handler = PlayerNotificationHandler.instance
    #
    #   target_handler.target = target
    #   player_handler.target = target
    #
    #   target_handler.successor = player_handler
    #
    #   target_handler
    # end

    def target
      @target ||= create_target
    end

    def create_target
      new_target = AVRCP::Target.new
      new_target.notifications_queue = notifications_queue
      # new_target.commands_queue = commands_queue
      new_target
    end
  end
end
