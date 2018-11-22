# frozen_string_literal: true

# Listener for Bluez Player objects
class BluezPlayerListener < BaseSignalListener
  def update(interface, signal, args)
    # LOGGER.debug(self.class) { "#update(#{interface}, #{signal}, #{args})" }
    case interface
    when BLUEZ_MEDIA_PLAYER
      # LOGGER.debug(self.class) { "Interface match!: #{BLUEZ_MEDIA_PLAYER}"  }
      delegate_media_player(signal, args)
    else
      LOGGER.warn(self.class) { "#{interface} not handled!" }
    end
  end

  private

  def delegate_media_player(signal, args)
    handler = handlers[BLUEZ_MEDIA_PLAYER]
    return false unless handler
    handler.handle(signal, args)
  end
end
