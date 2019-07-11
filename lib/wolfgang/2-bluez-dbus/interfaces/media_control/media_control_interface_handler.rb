# frozen_string_literal: true

module Wolfgang
  # MediaControlInterfaceHandler
  class MediaControlInterfaceHandler
    include Singleton
    include SignalDelegate

    PROG = 'MediaControlInterfaceHandler'
    PROPERTIES_CHANGED = '#properties_changed'

    attr_accessor :callback

    def responsibility
      BLUEZ_MEDIA_CONTROL
    end

    # @override SignalDelegate
    def properties_changed(signal)
      LogActually.interface_media_control.debug(PROG) { PROPERTIES_CHANGED }
      callback.call(signal)
    end
  end
end
