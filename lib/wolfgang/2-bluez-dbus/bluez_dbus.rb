# frozen_string_literal: true

module Wolfgang
  # Parent container for Bluez DBus
  class BluezDBus
    include Singleton
    include BluezDBusConfig

    PROG = 'BluezDBus'

    def prog
      PROG
    end

    def logger
      LogActually.service_bluez
    end

    def system_bus
      @system_bus ||= DBusAdapter.send(BUS_TYPE)
    end

    def service
      @service ||= create_service
    end

    def create_service
      logger.debug(prog) { 'Creating Bluez DBus Service...' }
      system_bus.service(SERVICE_NAME, BluezService)
    end

    def root_object
      service.root_object
    end

    def main_loop
      @main_loop ||= create_main_loop
    end

    def create_main_loop
      logger.debug(prog) { 'Creating main loop...' }
      DBus::Main.new
    end

    def signals(opts)
      logger.debug(prog) { "#signals(#{opts})" }
      service_listener = BluezServiceListener.instance
      service_listener.new_service(service, opts)
    end

    def run
      logger.debug(prog) { '#run' }
      Thread.new(system_bus, main_loop) do |bus, main|
        begin
          Thread.current[:name] = 'DBus Loop'
          logger.warn(prog) { 'DBus main loop starting.' }
          main << bus
          main.run
        rescue StandardError => e
          logger.error(prog) { e }
        end
        logger.warn(prog) { 'DBus main loop ending.' }
      end
    end

    def quit
      logger.debug(prog) { '#quit' }
      return false unless @main_loop
      loop = main_loop
      @main_loop = nil
      loop.quit
    end

    # Interface

    def self.service
      instance.service
    end

    def self.root
      instance.root_object
    end

    def self.run
      instance.run
    end

    def self.quit
      instance.quit
    end

    def self.signals(opts)
      instance.signals(opts)
    end
  end
end
