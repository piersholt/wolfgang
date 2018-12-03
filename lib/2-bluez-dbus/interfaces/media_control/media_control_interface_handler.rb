# frozen_string_literal: true

class MediaControlInterfaceHandler
  include Singleton
  include SignalDelegate

  attr_accessor :mq

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
    n = Notification.new(:media, :player_added, path: signal.player)
    mq.push(n)
  end

  def player_removed(signal)
    LOGGER.unknown(self.class) { 'Player no longer available!' }
    n = Notification.new(:media, :player_removed)
    mq.push(n)
  end

  def responsibility
    BLUEZ_MEDIA_CONTROL
  end
end
