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

      fetch_player_object_state(player)
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

    public

    def fetch_player_object_state(player)
      logger.info(PROG) { "#fetch_player_object_state(#{player})" }
      fetch_media_player_interface_state(player)
    rescue StandardError => e
      logger.error(prog) { e }
      e.backtrace.each { |line| logger.warn(prog) { line } }
    end

    private

    def fetch_media_player_interface_state(player)
      logger.info(prog) { "State Fetch: #{BLUEZ_MEDIA_PLAYER}" }
      player.media_player.property_get_all do |_, props|
        signal = PlayerPropertiesChanged.new(
          player.path, BLUEZ_MEDIA_PLAYER, props, []
        )
        logger.debug(PROG) do
          "State Fetch: sending #{BLUEZ_MEDIA_PLAYER} :properties_changed signal."
        end
        public_send(:properties_changed, signal)
      end
    end
  end
end
