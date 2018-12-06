# frozen_string_literal: true

# Comment
class MediaControlInterfaceHandler
  include Singleton
  include SignalDelegate

  attr_accessor :mq

  # @override SignalDelegate
  def properties_changed(signal)
    if signal.connected? && signal.player?
      player_available(signal)
    elsif signal.disconnected? && signal.no_player?
      player_removed(signal)
    end
  end

  private

  def player_available(signal)
    LOGGER.unknown(self.class) { 'Player available!' }
    n = Messaging::Notification.new(topic: :media, name: :player_added, properties: { path: signal.player })
    mq.push(n)
  end

  def player_removed(signal)
    LOGGER.unknown(self.class) { 'Player no longer available!' }
    n = Messaging::Notification.new(topic: :media, name: :player_removed)
    mq.push(n)
  end

  def responsibility
    BLUEZ_MEDIA_CONTROL
  end
end
