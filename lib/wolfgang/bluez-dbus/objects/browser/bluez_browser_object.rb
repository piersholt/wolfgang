# frozen_string_literal: true

module Wolfgang
  # Bluez MediaBrower Object
  class BluezMediaBrowserObject < ObjectAdapter
    include Properties

    include BluezMediaItem
  end
end
