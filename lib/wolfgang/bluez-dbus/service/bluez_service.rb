# frozen_string_literal: true

module Wolfgang
  # Wolfgang::BluezService
  class BluezService < ServiceAdapter
    include ObjectConstants
    include ObjectHelpers

    PROG = 'BluezService'

    def logger
      LogActually.service_bluez
    end

    # Get service root object: '/"
    def root_object
      logger.debug(PROG) { '#root_object()' }
      object_by_path(ROOT_OBJECT_PATH, BluezRootObject)
    end

    alias root root_object

    # Get core bluez object: '/org/bluez'
    def core_object
      logger.debug(PROG) { '#core_object()' }
      object_by_path(CORE_OBJECT_PATH, BluezCoreObject)
    end

    alias core core_object

    def controller_object(object_path)
      logger.debug(PROG) { "#controller_object(#{object_path})" }
      object_by_path(object_path, BluezControllerObject)
    end

    def device_object(object_path)
      logger.debug(PROG) { "#device_object(#{object_path})" }
      object_by_path(object_path, BluezDeviceObject)
    end

    def media_transport_object(object_path)
      logger.debug(PROG) { "#media_transport_object(#{object_path})" }
      object_by_path(object_path, BluezMediaTransportObject)
    end

    def player_object(object_path)
      logger.debug(PROG) { "#player_object(#{object_path})" }
      object_by_path(object_path, BluezPlayerObject)
    end

    def browser_object(object_path)
      logger.debug(PROG) { "#browser_object(#{object_path})" }
      object_by_path(object_path, BluezMediaBrowserObject)
    end

    def object_by_path(path, object_adapter)
      logger.debug(PROG) { "#object_by_path(#{path}, #{object_adapter})" }
      public_send(:[], path, adapter: object_adapter)
    end

    # ------- MODULE OBJECT FILTER HELPER

    def controller_paths
      logger.debug(PROG) { '#controller_paths()' }
      filter_objects(CONTROLLER_OBJECT_PATTERN)
    end

    def device_paths(&block)
      logger.debug(PROG) { "#device_paths(#{block ? true : false})" }
      filter_objects(DEVICE_OBJECT_PATTERN, &block)
    end

    # @deprecated in favour of #device_paths. Remove with bluetooth-manager.
    alias device_objects! device_paths

    def media_transport_paths
      logger.debug(PROG) { '#media_transport_paths()' }
      filter_objects(MEDIA_TRANSPORT_OBJECT_PATTERN)
    end

    def player_paths(&block)
      logger.debug(PROG) { '#player_paths()' }
      filter_objects(PLAYER_OBJECT_PATTERN, &block)
    end

    private

    def filter_objects(pattern, &block)
      logger.debug(PROG) do
        "#filter_objects(#{pattern}, #{block ? true : false})"
      end
      if block_given?
        root_object.get_managed_objects do |_, objects|
          logger.debug(PROG) { "get_managed_objects ->" }
          filtered_objects = apply_filter(objects, pattern)
          logger.debug(PROG) { "filtered_objects => #{filtered_objects}" }
          case block_given?
          when false
            to_enum(:each, filtered_objects) unless block_given?
          when true
            i = 0
            while i < filtered_objects.length
              yield filtered_objects[i]
              i += 1
            end
          end
        end
        return true
      end
      objects = root_object.get_managed_objects
      apply_filter(objects, pattern)
    rescue StandardError => e
      logger.error(PROG) { e }
      e.backtrace.each { |l| logger.error(PROG) { l } }
    end

    MATCH = 'Match'
    NO_MATCH = 'No Match'

    def apply_filter(objects, pattern)
      logger.debug(PROG) { "#apply_filter(#{objects&.keys}, #{pattern})" }
      result = objects.find_all do |path, _|
        matches = path.scan(pattern)
        result = matches.length.positive?
        logger.debug(PROG) { "#{path} => #{result ? MATCH : NO_MATCH}" }
        result
      end

      return [] if result.empty?
      logger.debug(PROG) { result }
      result.to_h.keys
    end
  end
end
