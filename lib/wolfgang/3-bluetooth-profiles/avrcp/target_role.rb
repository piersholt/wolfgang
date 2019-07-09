# frozen_string_literal: true

module Wolfgang
  module AVRCP
    # TargetRole
    class TargetRole
      attr_accessor :notifications_queue, :commands_queue

      def initialize(outgoing_notifications_queue)
        self.notifications_queue = outgoing_notifications_queue
        setup_object_handlers
        setup_device_handlers
        setup_player_handlers
      end

      def target
        @target ||= create_target
      end

      alias t target

      private

      # initialize =>
      def setup_object_handlers
        root_listener = BluezRootListener.instance
        root_listener.declare_primary_delegate(configure_object_delegates)
      end

      # initialize =>
      def setup_device_handlers
        device_listener = BluezDeviceListener.instance
        device_listener.declare_primary_delegate(configure_device_delegates)
      end

      # initialize =>
      def setup_player_handlers
        player_listener = BluezPlayerListener.instance
        player_listener.declare_primary_delegate(configure_player_delegates)
      end

      # setup_object_handlers =>
      def configure_object_delegates
        player_handler    = PlayerObjectHandler.instance
        browser_handler   = BrowserObjectHandler.instance
        transport_handler = TransportObjectHandler.instance

        player_handler.successor  = browser_handler
        browser_handler.successor = transport_handler

        player_handler
      end

      # setup_device_handlers =>
      def configure_device_delegates
        media_control_handler = MediaControlInterfaceHandler.instance
        media_control_handler.callback = target.target_control_callback
        media_control_handler
      end

      # setup_player_handlers =>
      def configure_player_delegates
        media_player_handler = MediaPlayerInterfaceHandler.instance
        media_player_handler.callback = target.player_callback
        media_player_handler
      end

      # target =>
      def create_target
        LogActually.avrcp.debug(self.class) { "Create Target." }
        new_target = AVRCP::Target.new
        LogActually.avrcp.debug(self.class) { "@new_target => #{new_target.__id__}" }
        new_target.notifications_queue = notifications_queue
        LogActually.avrcp.debug(self.class) { "@new_target.notifications_queue => #{new_target.notifications_queue}" }
        # new_target.commands_queue = commands_queue
        new_target
      end
    end
  end
end
