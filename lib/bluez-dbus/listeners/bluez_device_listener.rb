# frozen_string_literal: true

# Listener for Bluez Device objects
class BluezDeviceListener < BluezBaseListener
  def update(interface, signal, args)
    case interface
    when BLUEZ_DEVICE
      delegate_device(signal, args)
    when BLUEZ_MEDIA_CONTROL
      delegate_media_control(signal, args)
    else
      LOGGER.warn(self.class) { "#{interface} not handled!" }
    end
  end

  private

  def delegate_device(signal, args)
    handler = handlers[BLUEZ_DEVICE]
    return false unless handler
    handler.handle(signal, args)
  end

  def delegate_media_control(signal, args)
    handler = handlers[BLUEZ_MEDIA_CONTROL]
    return false unless handler
    handler.handle(signal, args)
  end
end
