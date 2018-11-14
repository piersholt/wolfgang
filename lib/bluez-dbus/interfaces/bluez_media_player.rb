# frozen_string_literal: true

# Bluez Interface: org.bluez.MediaPlayer1
module BluezMediaPlayer
  def play
    interface(BLUEZ_MEDIA_PLAYER).Play do |resp|
      LOGGER.info(self.class) { "#Play callback? #{resp}" }
    end
  end

  def pause
    interface(BLUEZ_MEDIA_PLAYER).Pause do |resp|
      LOGGER.info(self.class) { "#Pause callback? #{resp}" }
    end
  end

  def stop
    interface(BLUEZ_MEDIA_PLAYER).Stop
  end

  def next
    interface(BLUEZ_MEDIA_PLAYER).Next do |resp|
      LOGGER.info(self.class) { "#Next callback? #{resp}" }
    end
  end

  def previous
    interface(BLUEZ_MEDIA_PLAYER).Previous do |resp|
      LOGGER.info(self.class) { "#Previous callback? #{resp}" }
    end
  end

  def fast_forward
    interface(BLUEZ_MEDIA_PLAYER).FastForward
  end

  def rewind
    interface(BLUEZ_MEDIA_PLAYER).Rewind
  end
end
