# frozen_string_literal: true

module Wolfgang
  # VirtualCarKit
  class VirtualCarKit
    include BluezDBusInterface
    include ManageableThreads
    attr_reader :device, :controller
    include Yabber::API

    PROG = 'VirtualCarKit'

    def logger
      LogActually.vcc
    end

    def initialize(options)
      @options = options
      @device = Bluetooth::Device.instance
      @device.notifications_queue = outgoing_notifications_queue

      @controller = Bluetooth::Profile::AVRCP::Controller.instance
      @controller.notifications_queue = outgoing_notifications_queue

      # @manager = Manager.new(outgoing_notifications_queue)
      # @controller = Controller.new(outgoing_notifications_queue)

      setup_outgoing_notification_handlers
      setup_incoming_command_handlers
    end

    NO_ARGS = {}.freeze

    def start
      announce(Yabber::Constants::DEVICE)
      signals(NO_ARGS)
      run
      raise(NotImplementedError, 'Pry Console') if @options.console
      LOGGER.debug(PROG) { 'Main Thread / Entering keep alive loop...' }
      loop do
        print_status(true)
        sleep 5
      end
    rescue NotImplementedError
      LOGGER.info(PROG) { 'Console start.' }
      binding.pry
      LOGGER.info(PROG) { 'Console end.' }
    end

    # Commands

    def setup_incoming_command_handlers
      logger.debug(PROG) { '#setup_incoming_command_handlers' }
      primary = setup_incoming_command_delegates
      command_listener = CommandListener.instance
      command_listener.declare_primary_delegate(primary)
      command_listener.start_subscriber
      command_listener.start_server
    end

    def setup_incoming_command_delegates
      logger.debug(PROG) { '#setup_incoming_command_delegates' }
      device_handler = DeviceHandler.instance
      device_handler.device = device

      media_handler = MediaHandler.instance
      media_handler.controller = controller

      target_handler = TargetHandler.instance
      target_handler.controller = controller
      target_handler.device = device

      wilhelm_handler = WolfgangHandler.instance

      media_handler.successor = target_handler
      target_handler.successor = device_handler
      device_handler.successor = wilhelm_handler

      media_handler
    end

    # Notifications

    def outgoing_notifications_queue
      @outgoing_notifications_queue ||= Queue.new
    end

    def setup_outgoing_notification_handlers
      logger.debug(PROG) { '#setup_outgoing_notification_handlers' }
      primary = configure_outgoing_notification_delegates
      notification_listener = NotificationListener.instance
      notification_listener.declare_primary_delegate(primary)
      notification_listener.listen(outgoing_notifications_queue)
    end

    def configure_outgoing_notification_delegates
      logger.debug(PROG) { '#configure_outgoing_notification_delegates' }
      player_handler = PlayerNotificationHandler.instance
      target_handler = TargetNotificationHandler.instance
      manager_handler = ManagerNotificationHandler.instance

      player_handler.successor = target_handler
      target_handler.successor = manager_handler

      player_handler
    end
  end
end
