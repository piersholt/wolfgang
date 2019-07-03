# frozen_string_literal: true

# Handle ObjectManager signals related to Player objects
# TODO: maybe subclass this for Player and BrowseablePlayer?
class PlayerObjectHandler
  include Singleton
  include SignalDelegate

  def name
    'Player'
  end

  def interfaces_added(signal)
    LogActually.media_player.info(name) { "New media player! #{signal.object_suffixed}." }
    LogActually.media_player.debug(name) { "#{signal.object_suffixed} includes #{responsibility} interface(s)." }
    player_object = BluezDBus.service.player(signal.object_path)
    # new_player(player_object)
    BluezPlayerListener.instance.new_player(player_object)
  end

  private

  def responsibility
    [BLUEZ_MEDIA_PLAYER, BLUEZ_MEDIA_FOLDER].freeze
  end

  def new_player(player)
    LogActually.media_player.debug(name) { 'Media player signal setup... properties_changed' }
    player
      .properties
      .listen(
        :properties_changed,
        BluezPlayerListener.instance,
        klass: PlayerPropertiesChanged
      )
  end
end