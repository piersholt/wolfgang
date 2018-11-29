# frozen_string_literal: true

# Handle ObjectMananger signals related to Player objects
# TODO: maybe subclass this for Player and BrowseablePlayer?
class PlayerObjectHandler
  include Singleton
  include ObjectManangerHandler

  ASSOCIATED_INTERFACES = [BLUEZ_MEDIA_PLAYER, BLUEZ_MEDIA_FOLDER].freeze

  def take_responsibility(signal)
    LOGGER.unknown(self.class) { "New media player! #{signal.object_suffixed} includes #{BLUEZ_MEDIA_PLAYER} interface." }
    player_object = BluezDBus.service.player(signal.object_path)
    new_player(player_object)
  end

  private

  def responsibilities
    ASSOCIATED_INTERFACES
  end

  def new_player(player)
    LOGGER.debug(self.class) { 'Media player signal setup...' }
    player.properties
          .properties_changed(BluezPlayerListener.instance,
                              :properties_changed,
                              PlayerPropertiesChanged)
  end
end
