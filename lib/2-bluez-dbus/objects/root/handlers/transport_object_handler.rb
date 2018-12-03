# frozen_string_literal: true

# Handle ObjectMananger signals related to Media Trasport objects
class TransportObjectHandler
  include Singleton
  include SignalDelegate

  ASSOCIATED_INTERFACES = [BLUEZ_MEDIA_TRANSPORT].freeze

  def interfaces_added(signal)
    LOGGER.unknown(self.class) { "New media endpoint! #{signal.object_suffixed}" }
    transport_object = BluezDBus.service.media_transport(signal.object_path)
    new_media_transport(transport_object)
  end

  private

  def responsibility
    ASSOCIATED_INTERFACES
  end

  def new_media_transport(media_transport)
    LOGGER.debug(self.class) { 'Media media_transport signal setup...' }
    media_transport.properties.properties_changed(BluezPlayerListener.instance, :properties_changed)
  end
end
