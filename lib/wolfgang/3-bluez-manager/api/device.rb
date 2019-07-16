# frozen_string_literal: true

module Wolfgang
  module BluezClientAPI
    # Device
    module Device
      include BluezClientAPI::Service
      include ObjectConstants

      PROG = 'Manager Device'

      attr_reader :device_list, :device_info

      def devices
        service.device_objects!(devices_callback)
        true
      end

      def info(device_address = selected_device)
        Thread.new(&info_callback(device_address))
      end

      def info_callback(device_address)
        proc do
          logger.debug(prog) { "#info => callback" }
          logger.debug(prog) { "service.device(#{device_address})" }
          device_object = service.device(device_address)
          logger.debug(prog) { device_object.class }
          device_properties = device_object.device.property_get_all
          logger.debug(prog) { device_properties }
          @device_info = device_properties
          print_device_info
        end
      end

      def target(device_address)
        @selected_device = device_address
      end

      def connect(device_address = selected_device)
        logger.info(prog) { "Device: #{device_address}" }
        device_object = service.device(device_address)
        device_object.connect
      end

      def disconnect(device_address = selected_device)
        logger.info(prog) { "Device: #{device_address}" }
        device_object = service.device(device_address)
        device_object.disconnect
      end

      def selected_device
        raise(NameError, 'No connected device!') unless @selected_device
        @selected_device
      end

      def logger
        LogActually.device
      end

      def prog
        PROG
      end

      def devices_callback
        proc do |response, mananged_objects|
          logger.debug(prog) { '#devices => callback!' }
          begin
            # logger.debug(prog) { "response: #{response}" }
            logger.debug(prog) { "mananged_objects =>" }
            mananged_objects.each do |k, _|
              logger.debug(prog) { k }
            end
            objects = mananged_objects

            # logger.debug(prog) { "Object paths: #{objects.keys}" }
            result = objects.find_all do |path, _|
              matches = path.scan(DEVICE_OBJECT_PATTERN)
              result = matches.length.positive?
              logger.debug(prog) { "Checking #{path}... => #{result}" }
              result
            end

            return [] if result.empty?
            # logger.debug(prog) { result }
            device_paths = result.to_h.keys
            # logger.debug(prog) { device_paths }

            @device_list = device_paths.map do |path|
              logger.debug(prog) { path }
              device_object = service.device(path)
              logger.debug(prog) { device_object.class }
              nickname = device_object.device.alias
              address = device_object.device.address
              [address, nickname]
            end
            print_device_list
            true
          rescue StandardError => e
            logger.error(prog) { e }
            e.backtrace.each { |line| logger.warn(prog) { line } }
          end
        end
      end

      def print_device_list
        device_list.each do |device|
          logger.info(prog) { device }
        end
        true
      end

      def print_device_info
        logger.info(prog) { device_info }
        true
      end
    end
  end
end
