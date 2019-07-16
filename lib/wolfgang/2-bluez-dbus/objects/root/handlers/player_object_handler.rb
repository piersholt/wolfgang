# frozen_string_literal: true

module Wolfgang
  # Handle ObjectManager signals related to Player objects
  # TODO: maybe subclass this for Player and BrowseablePlayer?
  class PlayerObjectHandler
    include Singleton
    include SignalDelegate

    PROG = 'BrowserObjectHandler'

    def prog
      PROG
    end

    def logger
      LogActually.object_root
    end

    def interfaces_added(signal)
      logger.info(prog) { "New media player! #{signal.object_suffixed}." }
      logger.debug(prog) { "#{signal.object_suffixed} includes #{responsibility} interface(s)." }
      player_object = BluezDBus.service.player(signal.object_path)
      # new_player(player_object)
      BluezPlayerListener.instance.new_player(player_object)
    end

    private

    def responsibility
      [BLUEZ_MEDIA_PLAYER, BLUEZ_MEDIA_FOLDER].freeze
    end

    # @deprecated
    # See BluezPlayerListener.instance.new_player
    def new_player(player)
      logger.debug(prog) { 'Media player signal setup... properties_changed' }
      player.properties.listen(
        :properties_changed,
        BluezPlayerListener.instance,
        klass: PlayerPropertiesChanged
      )
    end
  end
end
