# frozen_string_literal: true

class BluezRootListener < BaseSignalListener
  include Singleton

  # This is a generic interface signal listener
  # it an be overridden; in this case by an object listener

  PROC = 'Root'

  def new_root(root)
    LOGGER.debug(PROC) { 'New Root!' }
    root.object_manager.listen(:interfaces_added, self)
    root.object_manager.listen(:interfaces_removed, self)
  end

  # @override ObjectManagerListener
  def interfaces_added(signal)
    super(signal)
  end

  # @override ObjectManagerListener
  def interfaces_removed(signal)
    super(signal)
  end

  # def interface_added(signal)
  #   self.proc = 'InterfaceAdded'
  #   super(signal)
  #
  #   player_listener = BluezPlayerListener.instance
  #
  #   if signal.added_interfaces.include?(BLUEZ_MEDIA_PLAYER)
  #     LOGGER.warn(proc) { "New media player! #{signal.object_suffixed} includes #{BLUEZ_MEDIA_PLAYER} interface." }
  #     player_object = BluezDBus.service.player(signal.object_path)
  #     player_listener.new_player(player_object)
  #   elsif signal.added_interfaces.include?(BLUEZ_MEDIA_FOLDER)
  #     LOGGER.warn(proc) { "New media folder! #{signal.object_suffixed}" }
  #     player_object = BluezDBus.service.player(signal.object_path)
  #     player_listener.new_player(player_object)
  #   elsif signal.added_interfaces.include?(BLUEZ_MEDIA_ITEM)
  #     LOGGER.warn(proc) { "New media item! #{signal.object_suffixed}" }
  #     browser_object = BluezDBus.service.browser(signal.object_path)
  #     player_listener.new_browser(browser_object)
  #   elsif signal.added_interfaces.include?(BLUEZ_MEDIA_TRANSPORT)
  #     LOGGER.warn(proc) { "New media endpoint! #{signal.object_suffixed}" }
  #     transport_object = BluezDBus.service.media_transport(signal.object_path)
  #     player_listener.new_media_transport(transport_object)
  #   end
  # end
end
