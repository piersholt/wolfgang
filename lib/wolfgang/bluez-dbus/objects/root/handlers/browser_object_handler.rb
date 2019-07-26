# frozen_string_literal: true

module Wolfgang
  # Handle ObjectManager signals related to Browser objects
  class BrowserObjectHandler
    include Singleton
    include SignalDelegate

    PROG = 'BrowserObjectHandler'

    def prog
      PROG
    end

    def logger
      LogActually.object_root
    end

    def interfaces_added(signal)
      logger.info(prog) { "New media item! #{signal.object_suffixed}." }
      logger.debug(prog) { "#{signal.object_suffixed} includes #{responsibility} interface(s)." }
      browser_object = BluezDBus.service.browser_object(signal.object_path)
      new_browser(browser_object)
    end

    private

    def responsibility
      [BLUEZ_MEDIA_ITEM].freeze
    end

    def new_browser(browser)
      logger.debug(prog) { 'Media borwser signal setup... :properties_changed' }
      browser.properties.listen(:properties_changed, BluezPlayerListener.instance)
    end
  end
end
