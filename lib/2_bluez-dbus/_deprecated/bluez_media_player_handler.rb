# frozen_string_literal: true

# Interface Signal Handler: org.bluez.MediaPlayer1
class BluezMediaPlayerHandler < BluezBaseHandler
  attr_writer :service

  def initialize(target = BLUEZ_MEDIA_PLAYER)
    super(target)
  end

  def handle(signal, args)
    LOGGER.info(self.class) { "#{signal}: #{args}" }

    case signal
    when 'PropertiesChanged'
      properties_changed(args)
    end
  end

  # def service(bluez_service)
  #   @service = bluez_service
  # end

  private

  def properties_changed(args)
    return true
  end
end
