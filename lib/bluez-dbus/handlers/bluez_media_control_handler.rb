# frozen_string_literal: true

# Interface Signal Handler: org.bluez.MediaControl1
class BluezMediaControlHandler < BluezBaseHandler
  PLAYER = 'Player'
  CONNECTED = 'Connected'

  attr_writer :service

  def initialize(target = BLUEZ_MEDIA_CONTROL)
    super(target)
  end

  def handle(signal, args)
    LOGGER.info(self.class) { "#{signal}: #{args}" }

    case signal
    when 'PropertiesChanged'
      properties_changed(args)
    end
  end

  # def service(bluez_service)
  #   @service = bluez_service
  # end

  private

  def properties_changed(args)
    if args[:changes].key?(PLAYER) || args[:removed].include?(PLAYER)
      player(args[:changes], args[:removed])
    end
  end

  def player(changes, removed)
    if changes.key?(CONNECTED) && changes[CONNECTED] == true
      LOGGER.info(self.class) { "New player object: #{changes[PLAYER]}"}
      # player_object = setup_player_object(changes[PLAYER])
      # LOGGER.info(self.class) { player_object }
      # LOGGER.info(self.class) { 'Attempting to play!' }
      # player_object.play
    elsif removed.include?(PLAYER)
      LOGGER.info(self.class) { "Player object removed!"}
    end
  end

  # def setup_player_object(player_object_path)
  #   player_object = @service.player_object_full(player_object_path)
  #   player_object.subscribe_to_changes
  #   player_listener = BluezPlayerListener.new
  #   player_listener.register_handler(BluezMediaPlayerHandler.new)
  #   player_object
  # end
end
