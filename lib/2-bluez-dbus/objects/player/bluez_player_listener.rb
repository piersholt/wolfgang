# frozen_string_literal: true

class BluezPlayerListener < BaseSignalListener
  include Singleton
  include SignalDelegator

  # @override PropertiesListener
  def properties_changed(signal)
    super(signal, 'Player#PropertiesChanged')
    delegate(:properties_changed, signal)
  rescue IfYouWantSomethingDone
    logger.warn(proc) { "Chain did not handle! (#{signal.path})" }
  end

  def name
    'PlayerListener'
  end

  def logger
    LogActually.media_player
  end

  def fetch_current_state(player)
    logger.debug(name) { '#fetch_current_state' }
    # logger.unknown(name) { "Interface: #{BLUEZ_DEVICE}" }
    # logger.unknown(name) { "\tObject player name: #{player.player.name}" }
    player_interface_props = player.media_player.property_get_all
    # parse_properties(player_interface_props)
    signal = PlayerPropertiesChanged.new(player.path, BLUEZ_MEDIA_PLAYER, player_interface_props, [])
    public_send(:properties_changed, signal)
    # logger.unknown(name) { "Interface: #{BLUEZ_MEDIA_CONTROL}" }
    # logger.unknown(name) { "\tObject player name: #{player.media_control.name}" }
    # parse_properties(player.media_control.property_get_all)
  rescue StandardError => e
    logger.error(name) { e }
    e.backtrace.each { |line| logger.warn(name) { line } }
  end

  def new_player(player)
    # self.proc = 'Player'
    logger.info(name) { "New Player! #{player.path_suffix}" }
    logger.debug(name) { "New player class => #{player.class}" }
    # properties_changed_signal_registration(player)
    # interface_called_signal_registration(player)
    fetch_current_state(player)
    logger.debug(name) { 'Media player signal setup... properties_changed' }
    player.properties.listen(:properties_changed,
                             BluezPlayerListener.instance,
                             klass: PlayerPropertiesChanged)
  end
end
