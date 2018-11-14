# frozen_string_literal: true

# Listener for Bluez Device objects
class BluezControllerListener < BluezBaseListener
  def update(interface, signal, args)
    case interface
    when BLUEZ_ADAPTER
      delegate_adapter(signal, args)
    when BLUEZ_GATT_MANAGER
      no_handler
    when BLUEZ_MEDIA
      no_handler
    when BLUEZ_NETWORK_SERVER
      no_handler
    else
      no_handler
    end
  end

  private

  def delegate_adapter(signal, args)
    handler = handlers[BLUEZ_ADAPTER]
    return false unless handler
    handler.handle(signal, args)
  end

  def no_handler
    LOGGER.warn(self.class) { "#{interface} not handled!" }
  end
end
