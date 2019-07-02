# frozen_string_literal: true

# Bluez MediaBrower Object
class BluezMediaBrowserObject < ObjectAdapter
  include Properties

  include BluezMediaItem
end
