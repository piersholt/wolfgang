# frozen_string_literal: true

module Wolfgang
  # Wolfgang::BluezService
  class BluezService < ServiceAdapter
    include ObjectConstants
    include ObjectHelpers

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
      filter_objects(CONTROLLER_OBJECT_PATTERN)
    end

    def device_objects
      filter_objects(DEVICE_OBJECT_PATTERN)
    end

    def device_objects!(filter_callback)
      filter_objects_callback(DEVICE_OBJECT_PATTERN, filter_callback)
    end

    def media_transport_objects
      filter_objects(MEDIA_TRANSPORT_OBJECT_PATTERN)
    end

    def player_objects
      filter_objects(PLAYER_OBJECT_PATTERN)
    end

    def filter_objects(pattern)
      LOGGER.debug(self.class) { "Filtering objects: #{pattern}" }
      objects = root_object.get_managed_objects

      # LOGGER.debug(self.class) { "Objects: #{objects}" }
      LOGGER.debug(self.class) { "Object paths: #{objects.keys}" }
      result = objects.find_all do |path, _|
        matches = path.scan(pattern)
        result = matches.length.positive?
        LOGGER.debug(self.class) { "Checking #{path}... => #{result}" }
        result
      end

      return [] if result.empty?
      LOGGER.debug(self.class) { result }
      result.to_h.keys
    rescue StandardError => e
      LOGGER.error(self.class) { e }
      e.backtrace.each { |l| LOGGER.error(self.class) { l } }
    end

    def filter_objects_callback(pattern, filter_callback)
      LOGGER.debug(self.class) { "Filtering objects: #{pattern}" }
      root_object.get_managed_objects(filter_callback)
    rescue StandardError => e
      LOGGER.error(self.class) { e }
      e.backtrace.each { |l| LOGGER.error(self.class) { l } }
    end
  end
end
