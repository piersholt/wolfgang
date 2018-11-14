class BluezMediaControlHandler
  def handle(signal, args)
    LOGGER.info("#{self.class}") { "#{signal}: #{args}" }
  end

  def target
    BLUEZ_MEDIA_CONTROL
  end
end

class BluezDeviceHandler
  def handle(signal, args)
    LOGGER.info("#{self.class}") { "#{signal}: #{args}" }
  end

  def new_player
    # listen for connected and player pending
    # parse the propers to get the player path
    # get the new player object
    # add observer to that object
    # subscribe to the changes

    # d = bluez_service.player_object(full_path)
    # d.add_observer(listener)
    # d.subscribe_to_changes
  end

  def target
    BLUEZ_DEVICE
  end
end

class BluezMediaControlHandler
  def handle(signal, args)
    LOGGER.info("#{self.class}") { "#{signal}: #{args}" }
  end

  def target
    BLUEZ_MEDIA_CONTROL
  end
end

class BluezListener
  def handle(handler)
    handlers[handler.target] = handler
  end

  def handlers
    @handlers ||= {}
  end

  def update(interface, signal, args)
    case interface
    when BLUEZ_MEDIA_CONTROL
      handlers[BLUEZ_MEDIA_CONTROL].handle(signal, args)
    when BLUEZ_DEVICE
      handlers[BLUEZ_DEVICE].handle(signal, args)
    when BLUEZ_MEDIA_CONTROL
      handlers[BLUEZ_MEDIA_CONTROL].handle(signal, args)
    end
  end
end
