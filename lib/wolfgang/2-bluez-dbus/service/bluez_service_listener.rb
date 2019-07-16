# frozen_string_literal: false

module Wolfgang
  # Wolfgang::BluezServiceListener
  class BluezServiceListener
    include Singleton

    PROG = 'BluezServiceListener'.freeze

    # pi@raspberrypi:~$ sudo bluetoothctl
    # [NEW] Controller B8:27:EB:E2:79:E7 pi_usb [default]
    # [NEW] Device 70:70:0D:11:CF:29 P7
    # [NEW] Device 4C:8D:79:8C:A0:94 P5
    # [NEW] Controller 00:1A:7D:DA:71:13 raspberrypi
    def new_service(
      service,
      root: BluezRootListener,
      controller: BluezControllerListener,
      device: BluezDeviceListener,
      player: BluezPlayerListener
    )
      logger.debug(prog) { 'New Service!' }

      initialize_root(service, root)
      initialize_controllers(service, controller)
      initialize_devices(service, device)
      initialize_players(service, player)
    end

    def logger
      LogActually.service_bluez
    end

    def prog
      PROG
    end

    # @desc: called on quiting Bluez
    def delete_service; end

    private

    def initialize_root(service, root_klass)
      logger.debug(prog) { "Initialize Root!" }
      logger.debug(prog) { "Root Object Listener: #{root_klass}" }
      new_root = service.root_object
      root_listener = root_klass.instance
      root_listener.new_root(new_root)
    end

    def initialize_controllers(service, controller_klass)
      logger.debug(prog) { "Initialize Controllers!" }
      logger.debug(prog) { "Controller Object Listener: #{controller_klass}" }
      controller_listener = controller_klass.instance
      controller_objects = service.controller_objects
      logger.info(prog) { "Controller Object(s): #{controller_objects.size}" }
      controller_objects.each do |controller_path|
        new_controller = service.controller(controller_path)
        logger.info(prog) { "Controller Object: #{new_controller.path}" }
        controller_listener.new_controller(new_controller)
      end
    end

    def initialize_devices(service, device_klass)
      logger.debug(prog) { "Initialize Devices!" }
      logger.debug(prog) { "Device Object Listener: #{device_klass}" }
      device_listener = device_klass.instance
      device_objects = service.device_objects
      logger.info(prog) { "Device Object(s): #{device_objects.size}" }
      device_objects.each do |device_path|
        new_device = service.device(device_path)
        logger.info(prog) { "Device Object: #{new_device.path}" }
        device_listener.new_device(new_device)
      end
    end

    def initialize_players(service, player_klass)
      logger.info(prog) { "Initialize Players!" }
      logger.debug(prog) { "Player Object Listener: #{player_klass}" }
      player_listener = player_klass.instance
      player_objects = service.player_objects
      logger.info(prog) { "Player Object(s): #{player_objects.size}" }
      player_objects.each do |player_path|
        new_player = service.player(player_path)
        logger.info(prog) { "Player Object: #{new_player.path}" }
        player_listener.new_player(new_player)
      end
    end
  end
end
