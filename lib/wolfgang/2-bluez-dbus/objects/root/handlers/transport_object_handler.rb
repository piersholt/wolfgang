# frozen_string_literal: true

module Wolfgang
  # Handle ObjectManager signals related to Media Trasport objects
  class TransportObjectHandler
    include Singleton
    include SignalDelegate

    PROG = 'MediaTransportHandler'

    def prog
      PROG
    end

    def logger
      LogActually.object_root
    end

    def interfaces_added(signal)
      logger.info(prog) { "New media endpoint! #{signal.object_suffixed}." }
      logger.debug(prog) { "#{signal.object_suffixed} includes #{responsibility} interface(s)." }
      transport_object = BluezDBus.service.media_transport(signal.object_path)
      new_media_transport(transport_object)
    end

    private

    def responsibility
      [BLUEZ_MEDIA_TRANSPORT].freeze
    end

    def new_media_transport(media_transport)
      logger.debug(prog) { 'Media media_transport signal setup...' }
      media_transport.properties.listen(:properties_changed, BluezPlayerListener.instance)
    end
  end
end
