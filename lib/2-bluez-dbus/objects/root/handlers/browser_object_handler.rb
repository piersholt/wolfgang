# frozen_string_literal: true

# Handle ObjectMananger signals related to Browser objects
class BrowserObjectHandler
  include Singleton
  include ObjectManangerHandler

  ASSOCIATED_INTERFACES = [BLUEZ_MEDIA_ITEM].freeze

  def take_responsibility(signal)
    LOGGER.unknown(self.class) { "New media item! #{signal.object_suffixed}" }
    browser_object = BluezDBus.service.browser(signal.object_path)
    new_browser(browser_object)
  end

  private

  def responsibilities
    ASSOCIATED_INTERFACES
  end

  def new_browser(browser)
    LOGGER.debug(self.class) { 'Media borwser signal setup...' }
    browser.properties
         .properties_changed(BluezPlayerListener.instance, :properties_changed)
  end
end
