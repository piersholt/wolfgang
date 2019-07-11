# frozen_string_literal: true

module Wolfgang
  # Handle ObjectManager signals related to Player objects
  # TODO: maybe subclass this for Player and BrowseablePlayer?
  class PlayerObjectHandler
    include Singleton
    include SignalDelegate

    def name
      'PlayerObjectHandler'
    end

    def logger
      LogActually.object_root
    end

    def interfaces_added(signal)
      logger.info(name) { "New media player! #{signal.object_suffixed}." }
      logger.debug(name) { "#{signal.object_suffixed} includes #{responsibility} interface(s)." }
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
      logger.debug(name) { 'Media player signal setup... properties_changed' }
      player
      .properties
      .listen(
        :properties_changed,
        BluezPlayerListener.instance,
        klass: PlayerPropertiesChanged
      )
    end
  end
end
