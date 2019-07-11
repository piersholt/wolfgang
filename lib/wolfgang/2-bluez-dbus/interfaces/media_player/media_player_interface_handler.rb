# frozen_string_literal: true

module Wolfgang
  # MediaPlayerInterfaceHandler
  class MediaPlayerInterfaceHandler
    include Singleton
    include SignalDelegate

    PROG = 'MediaPlayerInterfaceHandler'
    PROPERTIES_CHANGED = '#properties_changed'

    attr_accessor :callback

    def responsibility
      BLUEZ_MEDIA_PLAYER
    end

    # @override SignalDelegate
    def properties_changed(signal)
      LogActually.object_player.debug(PROG) { PROPERTIES_CHANGED }
      callback.call(signal)
    end
  end
end
