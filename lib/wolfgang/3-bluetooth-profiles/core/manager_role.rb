# frozen_string_literal: true

module Wolfgang
  module Core
    # ManagerRole
    class ManagerRole
      attr_accessor :notifications_queue, :commands_queue

      def initialize(outgoing_notifications_queue)
        self.notifications_queue = outgoing_notifications_queue
        setup_device_handlers
      end

      def manager
        @manager ||= create_manager
      end

      alias m manager

      private

      # initialize =>
      # BluezDeviceListener has primary delegate declared via TargetRole
      # which is initialized prior to ManagerRole. Thus, #append_successor
      # is called, not #declare_primary_delegate. Not ideal, but I know
      # I'll no NFI if I don't know it now...
      def setup_device_handlers
        device_listener = BluezDeviceListener.instance
        device_listener.append_successor(configure_device_delegates)
      end

      # setup_device_handlers ->
      def configure_device_delegates
        device_handler = DeviceInterfaceHandler.instance

        device_handler.signal_callback = manager.device_properties_changed_block
        device_handler.call_callback = manager.device_called_block

        device_handler
      end

      # manager =>
      def create_manager
        LogActually.core.debug(self.class) { "Create Manager." }
        manager = Core::Manager.new
        LogActually.core.debug(self.class) { "@manager => #{manager.__id__}" }
        manager.notifications_queue = notifications_queue
        LogActually.core.debug(self.class) { "@manager.notifications_queue => #{manager.notifications_queue}" }
        manager
      end
    end
  end
end
