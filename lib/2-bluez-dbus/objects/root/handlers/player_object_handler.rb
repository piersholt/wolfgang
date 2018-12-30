# frozen_string_literal: true

# Handle ObjectMananger signals related to Player objects
# TODO: maybe subclass this for Player and BrowseablePlayer?
class PlayerObjectHandler
  include Singleton
  include SignalDelegate


    def name
      'Player'
    end

  def interfaces_added(signal)
    LogActually.player.info(name) { "New media player! #{signal.object_suffixed}." }
    LogActually.player.debug(name) { "#{signal.object_suffixed} includes #{responsibility} interface(s)." }
    player_object = BluezDBus.service.player(signal.object_path)
    new_player(player_object)
  end

  private

  def responsibility
    [BLUEZ_MEDIA_PLAYER, BLUEZ_MEDIA_FOLDER].freeze
  end

  def new_player(player)
    LogActually.player.debug(name) { 'Media player signal setup... properties_changed' }
    player
      .properties
      .listen(
        :properties_changed,
        BluezPlayerListener.instance,
        klass: PlayerPropertiesChanged
      )
  end
end
