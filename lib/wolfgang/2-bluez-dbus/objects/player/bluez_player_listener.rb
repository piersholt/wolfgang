# frozen_string_literal: true

module Wolfgang
  # BluezPlayerListener
  class BluezPlayerListener < BaseSignalListener
    include Singleton
    include SignalDelegator

    PROG = 'PlayerListener'

    def prog
      PROG
    end

    def logger
      LogActually.object_player
    end

    # @override PropertiesListener
    def properties_changed(signal)
      logger.debug(prog) { "#properties_changed" }
      super(signal, 'Player#PropertiesChanged')
      delegate(:properties_changed, signal)
    rescue Yabber::IfYouWantSomethingDone
      logger.warn(prog) { "Chain did not handle! (#{signal.path})" }
    end

    # Called by BluezServiceListener when initialized
    def new_player(player)
      logger.info(prog) { "New Player! #{player.path_suffix}" }
      logger.debug(prog) { "New player class => #{player.class}" }

      properties_changed_signal_registration(player)

      fetch_current_state!(player)
    end

    private

    def properties_changed_signal_registration(player)
      logger.debug(prog) { 'Signal Registration: :properties_changed.' }
      player.properties.listen(
        :properties_changed,
        BluezPlayerListener.instance,
        klass: PlayerPropertiesChanged
      )
    end

    def fetch_current_state!(player)
      logger.debug(prog) { "State Fetch: #{BLUEZ_MEDIA_PLAYER}" }
      player_interface_props = player.media_player.property_get_all
      signal = PlayerPropertiesChanged.new(player.path, BLUEZ_MEDIA_PLAYER, player_interface_props, [])
      public_send(:properties_changed, signal)
    rescue StandardError => e
      logger.error(prog) { e }
      e.backtrace.each { |line| logger.warn(prog) { line } }
    end
  end
end
