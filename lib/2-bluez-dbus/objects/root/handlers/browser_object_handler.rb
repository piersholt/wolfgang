# frozen_string_literal: true

# Handle ObjectMananger signals related to Browser objects
class BrowserObjectHandler
  include Singleton
  include SignalDelegate


    def name
      'Media Browser'
    end

  def interfaces_added(signal)
    LogActually.media_browser.info(name) { "New media item! #{signal.object_suffixed}." }
    LogActually.media_browser.debug(name) { "#{signal.object_suffixed} includes #{responsibility} interface(s)." }
    browser_object = BluezDBus.service.browser(signal.object_path)
    new_browser(browser_object)
  end

  private

  def responsibility
    [BLUEZ_MEDIA_ITEM].freeze
  end

  def new_browser(browser)
    LogActually.media_browser.debug(name) { 'Media borwser signal setup... :properties_changed' }
    browser.properties.listen(:properties_changed, BluezPlayerListener.instance)
  end
end
