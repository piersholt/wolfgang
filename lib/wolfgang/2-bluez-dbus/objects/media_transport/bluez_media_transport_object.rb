# frozen_string_literal: true

module Wolfgang
  # Bluez MediaTransport Object
  class BluezMediaTransportObject < ObjectAdapter
    include Properties

    include BluezMediaTransport
  end
end
