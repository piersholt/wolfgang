# frozen_string_literal: true

# Parent container for Bluez DBus
class BluezDBus
  include Singleton
  include BluezDBusConfig

  def system_bus
    @system_bus ||= DBusAdapter.send(BUS_TYPE)
  end

  def service
    @service ||= system_bus.service(SERVICE_NAME, BluezService)
  end

  def root_object
    service.root_object
  end

  def main_loop
    @main_loop ||= DBus::Main.new
  end

  def signals
    service_listener = BluezServiceListener.instance
    service_listener.new_service(service)
  end

  def run
    Thread.new(system_bus, main_loop) do |bus, main|
      begin
        Thread.current[:name] = 'DBus Loop'
        LOGGER.warn(self.class) { 'DBus main loop starting.' }
        main << bus
        main.run
      rescue StandardError => e
        LOGGER.error(self.class) { e }
      end
      LOGGER.warn(self.class) { 'DBus main loop ending.' }
    end
  end

  def quit
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

  def self.signals
    instance.signals
  end
end
