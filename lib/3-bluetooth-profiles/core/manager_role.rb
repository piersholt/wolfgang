# frozen_string_literal: true

module Core
  # Comment
  class ManagerRole
    # include BluezDBusInterface

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

    # -------------------------- DEVICE --------------------------

    def setup_device_handlers
      primary = configure_device_delegates
      device_listener = BluezDeviceListener.instance
      device_listener.append_successor(primary)
    end

    def configure_device_delegates
      device_handler = DeviceInterfaceHandler.instance

      device_handler.signal_callback = manager.device_properties_changed_block
      device_handler.call_callback = manager.device_called_block

      device_handler
    end

    # ------------------------------------------------------------

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
