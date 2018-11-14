class BluezDeviceHandler < BluezBaseHandler
  def initialize(target = BLUEZ_DEVICE)
    super(target)
  end

  def handle(signal, args)
    LOGGER.info("#{self.class}") { "#{signal}: #{args}" }
  end
end
