# frozen_string_literal: true

module Wolfgang
  # Bluez Interface: org.bluez.MediaPlayer1
  module BluezMediaPlayer
    # Comment
    module Methods
      include InterfaceConstants
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
        interface(BLUEZ_MEDIA_PLAYER).Stop do |resp|
          LOGGER.info(self.class) { "#Stop callback? #{resp}" }
        end
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
        interface(BLUEZ_MEDIA_PLAYER).FastForward do |resp|
          LOGGER.info(self.class) { "#FastForward callback? #{resp}" }
        end
      end

      def rewind
        interface(BLUEZ_MEDIA_PLAYER).Rewind do |resp|
          LOGGER.info(self.class) { "#Rewind callback? #{resp}" }
        end
      end
    end
  end
end
