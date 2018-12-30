# frozen_string_literal: true

# Handle ObjectMananger signals related to Media Trasport objects
class TransportObjectHandler
  include Singleton
  include SignalDelegate

  ASSOCIATED_INTERFACES = [BLUEZ_MEDIA_TRANSPORT].freeze

  def name
    'Media Transport'
  end

  def interfaces_added(signal)
    LogActually.media_transport.info(name) { "New media endpoint! #{signal.object_suffixed}." }
    LogActually.media_transport.debug(name) { "#{signal.object_suffixed} includes #{responsibility} interface(s)." }
    transport_object = BluezDBus.service.media_transport(signal.object_path)
    new_media_transport(transport_object)
  end

  private

  def responsibility
    ASSOCIATED_INTERFACES
  end

  def new_media_transport(media_transport)
    media_transport.properties.properties_changed(BluezPlayerListener.instance, :properties_changed)
    LogActually.media_transport.debug(name) { 'Media media_transport signal setup...' }
  end
end
