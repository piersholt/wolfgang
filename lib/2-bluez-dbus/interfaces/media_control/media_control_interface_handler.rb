# frozen_string_literal: true

class MediaControlInterfaceHandler
  include Singleton
  include PropertiesHandler

  attr_accessor :mq

  ASSOCIATED_INTERFACE = BLUEZ_MEDIA_CONTROL

  def take_responsibility(signal)
    if signal.connected? && signal.player?
      player_available(signal)
    elsif signal.disconnected? && signal.no_player?
      player_removed(signal)
    end
  end

  private

  def player_available(signal)
    LOGGER.unknown('MediaControl Handler') { 'Player available!' }
    n = Notification.new(:media, :player_added, path: signal.player)
    mq.push(n)
  end

  def player_removed(signal)
    LOGGER.unknown('MediaControl Handler') { 'Player no longer available!' }
    n = Notification.new(:media, :player_removed)
    mq.push(n)
  end

  def responsibility
    ASSOCIATED_INTERFACE
  end
end
