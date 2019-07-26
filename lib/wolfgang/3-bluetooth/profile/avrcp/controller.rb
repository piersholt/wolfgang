# frozen_string_literal: true

require_relative 'controller/constants'
require_relative 'controller/actions'
require_relative 'controller/notifications'
require_relative 'controller/signals'

module Wolfgang
  module Bluetooth
    module Profile
      module AVRCP
        # Bluetooth Service: AVRCP Controller
        class Controller
          include Singleton

          include BluezDBusInterface

          include Constants
          include Signals
          include Notifications
          include Actions

          def initialize
            setup_root_object_handlers
            setup_device_object_handlers
            setup_player_object_handlers
          end

          def object(path)
            logger.debug(PROG) { "#object(#{path}), block: #{block_given?}" }
            service.player_object(path)&.media_player&.property_get_all do |_, properties|
              logger.debug(PROG) { "property_get_all -> block_given? => #{block_given?}" }
              yield(path, properties) if block_given?
              properties
            end
          end

          def targets
            logger.debug(PROG) { "#targets, block_given? => #{block_given?}" }
            service.device_paths do |path|
              logger.info(PROG) { "player path => #{path}" }
              service.device_object(path)&.media_control&.property_get_all do |_, properties|
                logger.debug(PROG) { "property_get_all -> block_given? => #{block_given?}" }
                yield(path, properties) if block_given?
                properties
              end
            end
          end

          def players
            logger.debug(PROG) { "#players, block_given? => #{block_given?}" }
            service.player_paths do |path|
              logger.info(PROG) { "player path => #{path}" }
              service.player_object(path)&.media_player&.property_get_all do |_, properties|
                logger.debug(PROG) { "property_get_all -> block_given? => #{block_given?}" }
                yield(path, properties) if block_given?
                properties
              end
            end
          end

          def player(path)
            logger.debug(PROG) { "#player(#{path}), block: #{block_given?}" }
            service.player_object(path)&.media_player&.property_get_all do |_, properties|
              logger.debug(PROG) { "property_get_all -> block_given? => #{block_given?}" }
              yield(path, properties) if block_given?
              properties
            end
          end

          alias objects players

          def fetch_object_states
            logger.debug(PROG) { '#fetch_object_states' }

            service.device_paths do |path|
              # logger.info(PROG) { "device path => #{path}" }
              service.device_object(path)&.media_control&.property_get_all do |_, properties|
                # logger.debug(PROG) { "property_get_all -> block_given? => #{block_given?}" }
                media_control_properties_changed(
                  DevicePropertiesChanged.new(path, BLUEZ_MEDIA_CONTROL, properties, [])
                )
              end
            end
          end

          def player_references
            @player_references ||= {}
          end

          private

          # initialize =>
          def setup_root_object_handlers
            logger.debug(PROG) { '#setup_root_object_handlers' }
            root_listener = BluezRootListener.instance
            root_listener.declare_primary_delegate(configure_root_object_delegates)
          end

          # initialize =>
          def setup_device_object_handlers
            logger.debug(PROG) { '#setup_device_object_handlers' }
            device_listener = BluezDeviceListener.instance
            device_listener.append_successor(configure_device_object_delegates)
          end

          # initialize =>
          def setup_player_object_handlers
            logger.debug(PROG) { '#setup_player_object_handlers' }
            player_listener = BluezPlayerListener.instance
            player_listener.declare_primary_delegate(configure_player_object_delegates)
          end

          # setup_root_object_handlers =>
          def configure_root_object_delegates
            logger.debug(PROG) { '#configure_root_object_delegates' }
            player_handler    = PlayerObjectHandler.instance
            browser_handler   = BrowserObjectHandler.instance
            transport_handler = TransportObjectHandler.instance

            player_handler.successor  = browser_handler
            browser_handler.successor = transport_handler

            player_handler
          end

          # setup_device_object_handlers =>
          def configure_device_object_delegates
            logger.debug(PROG) { '#configure_device_object_delegates' }
            media_control_handler = MediaControlInterfaceHandler.instance
            media_control_handler.callback = media_control_properties_changed_block
            media_control_handler
          end

          # setup_player_object_handlers =>
          def configure_player_object_delegates
            logger.debug(PROG) { '#configure_player_object_delegates' }
            media_player_handler = MediaPlayerInterfaceHandler.instance
            media_player_handler.callback = media_player_properties_changed_block
            media_player_handler
          end
        end
      end
    end
  end
end
