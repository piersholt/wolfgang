# frozen_string_literal: true

# Bluez Interface: org.bluez.MediaPlayer1
module BluezMediaPlayer
  include InterfaceConstants
  include Methods
  include Properties

  def media_player
    self.default_iface = BLUEZ_MEDIA_PLAYER
    @selected_interface = BLUEZ_MEDIA_PLAYER
    self
  end

  private

  def media_player_interface
    interface(BLUEZ_MEDIA_PLAYER)
  end

  def media_player_property(property)
    property_get(BLUEZ_MEDIA_PLAYER, property)
  end
end
