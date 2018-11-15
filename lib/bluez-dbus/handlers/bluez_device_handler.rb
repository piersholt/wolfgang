class BluezDeviceHandler < BluezBaseHandler
  def initialize(target = BLUEZ_DEVICE)
    super(target)
  end

  def handle(signal, args)
    LOGGER.info("#{self.class}") { "#{signal}: #{args.find_all { |k,_| k != :state }}" }
    LOGGER.info("#{self.class}") { "State: #{args[:state]}" }
  end
end
