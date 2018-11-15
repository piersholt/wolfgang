class BluezAdapterHandler < BluezBaseHandler
  def initialize(target = BLUEZ_ADAPTER)
    super(target)
  end

  def handle(signal, args)
    LOGGER.info("#{self.class}") { "#{signal}: #{args}" }
  end
end
