# frozen_string_literal: true

module Wolfgang
  # Handle ObjectManager signals related to Media Trasport objects
  class TransportObjectHandler
    include Singleton
    include SignalDelegate

    def name
      'Root#MediaTransportHandler'
    end

    def interfaces_added(signal)
      LogActually.media_transport.info(name) { "New media endpoint! #{signal.object_suffixed}." }
      LogActually.media_transport.debug(name) { "#{signal.object_suffixed} includes #{responsibility} interface(s)." }
      transport_object = BluezDBus.service.media_transport(signal.object_path)
      new_media_transport(transport_object)
    end

    private

    def responsibility
      [BLUEZ_MEDIA_TRANSPORT].freeze
    end

    def new_media_transport(media_transport)
      LogActually.media_transport.debug(name) { 'Media media_transport signal setup...' }
      media_transport.properties.listen(:properties_changed, BluezPlayerListener.instance)
    end
  end
end
