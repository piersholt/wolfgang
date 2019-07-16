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
      root
    end

    # Get core bluez object: '/org/bluez'
    def core_object
      core
    end

    # Get controller/adapter object: '/org/bluez/hciX'
    def controller_object(controller_index)
      path = controller_path(controller_index)
      controller(path)
    end

    # Get device object: '/org/bluez/hciX/dev_XX_XX_XX_XX_XX_XX'
    def device_object(controller_index, device_address)
      path = device_path(controller_index, device_address)
      public_send(:[], path, adapter: BluezDeviceObject)
    end

    def media_transport_object(controller_index, device_address, file_descriptor)
      path = transport_path(controller_index, device_address, file_descriptor)
      media_transport(path)
    end

    def player_object(controller_index, device_address, player_index)
      path = player_path(controller_index, device_address, player_index)
      player(path)
    end

    # ------- MODULE GET HELPERS

    def root(full_path = ROOT_OBJECT_PATH)
      object_by_path(full_path, BluezRootObject)
    end

    def core(full_path = CORE_OBJECT_PATH)
      object_by_path(full_path, BluezCoreObject)
    end

    def controller(full_path)
      object_by_path(full_path, BluezControllerObject)
    end

    def device(full_path)
      object_by_path(full_path, BluezDeviceObject)
    end

    def media_transport(full_path)
      object_by_path(full_path, BluezMediaTransportObject)
    end

    def player(full_path)
      object_by_path(full_path, BluezPlayerObject)
    end

    def browser(full_path)
      object_by_path(full_path, BluezMediaBrowserObject)
    end

    def object_by_path(path, object_adapter)
      public_send(:[], path, adapter: object_adapter)
    end

    # ------- MODULE OBJECT FILTER HELPER

    def controller_objects
      logger.debug(PROG) { "#controller_objects()" }
      filter_objects(CONTROLLER_OBJECT_PATTERN)
    end

    def device_objects(&block)
      logger.debug(PROG) { "#device_objects(#{block ? true : false})" }
      filter_objects(DEVICE_OBJECT_PATTERN, &block)
    end

    alias device_objects! device_objects

    def media_transport_objects
      logger.debug(PROG) { "#media_transport_objects()" }
      filter_objects(MEDIA_TRANSPORT_OBJECT_PATTERN)
    end

    def player_objects
      logger.debug(PROG) { "#player_objects()" }
      filter_objects(PLAYER_OBJECT_PATTERN)
    end

    def filter_objects(pattern, &block)
      logger.debug(PROG) { "#filter_objects(#{pattern}, #{block ? true : false})" }
      return root_object.get_managed_objects(&bhostnlock) if block
      objects = root_object.get_managed_objects
      apply_filter(objects, pattern)
    rescue StandardError => e
      logger.error(PROG) { e }
      e.backtrace.each { |l| logger.error(PROG) { l } }
    end

    def apply_filter(objects, pattern)
      logger.debug(PROG) { "#apply_filter(#{objects&.keys}, #{pattern})" }
      result = objects.find_all do |path, _|
        matches = path.scan(pattern)
        result = matches.length.positive?
        logger.debug(PROG) { "Checking #{path}... => #{result}" }
        result
      end

      return [] if result.empty?
      logger.debug(PROG) { result }
      result.to_h.keys
    end
  end
end
