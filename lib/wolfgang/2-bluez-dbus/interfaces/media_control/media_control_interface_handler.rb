# frozen_string_literal: true

module Wolfgang
  # MediaControlInterfaceHandler
  class MediaControlInterfaceHandler
    include Singleton
    include SignalDelegate

    # attr_accessor :mq
    # attr_accessor :target
    PROG = 'MediaControlInterfaceHandler'
    PROPERTIES_CHANGED = '#properties_changed'

    attr_accessor :callback

    def responsibility
      BLUEZ_MEDIA_CONTROL
    end

    # @override SignalDelegate
    def properties_changed(signal)
      LogActually.media_control.debug(PROG) { PROPERTIES_CHANGED }
      callback.call(signal)
      # if signal.connected? && signal.player?
      #   player_added(signal)
      # elsif signal.disconnected? && signal.no_player?
      #   player_removed(signal)
      # end
    end

    # private

    # def player_added(signal)
    #   LOGGER.unknown(self.class) { 'Player available!' }
    #   n = Messaging::Notification.new(topic: :target, name: :player_added, properties: { path: signal.player })
    #   mq.push(n)
    # end
    #
    # def player_removed(_)
    #   LOGGER.unknown(self.class) { 'Player no longer available!' }
    #   n = Messaging::Notification.new(topic: :target, name: :player_removed)
    #   mq.push(n)
    # end
  end
end
