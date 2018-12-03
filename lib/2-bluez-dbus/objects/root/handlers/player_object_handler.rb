# frozen_string_literal: true

# Handle ObjectMananger signals related to Player objects
# TODO: maybe subclass this for Player and BrowseablePlayer?
class PlayerObjectHandler
  include Singleton
  include SignalDelegate
  
  def interfaces_added(signal)
    LOGGER.unknown(self.class) { "New media player! #{signal.object_suffixed} includes #{BLUEZ_MEDIA_PLAYER} interface." }
    player_object = BluezDBus.service.player(signal.object_path)
    new_player(player_object)
  end

  private

  def responsibility
    [BLUEZ_MEDIA_PLAYER, BLUEZ_MEDIA_FOLDER].freeze
  end

  def new_player(player)
    LOGGER.debug(self.class) { 'Media player signal setup...' }
    player.properties
          .properties_changed(BluezPlayerListener.instance,
                              :properties_changed,
                              PlayerPropertiesChanged)
  end
end
