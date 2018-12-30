# frozen_string_literal: true

module BluezDevice
  # Properties of Bluez Interface: org.bluez.Device1
  module Properties
    def connected?
      device_property('Connected')
    end

    def paired?
      device_property('Paired')
    end

    def name
      device_property('Name')
    end

    def address
      device_property('Address')
    end

    def klass
      device_property('Class')
    end

    def uuids
      device_property('UUIDs')
    end

    def trusted?
      device_property('Trusted')
    end

    def blocked?
      device_property('Blocked')
    end

    def alias
      device_property('Alias')
    end

    def adapter
      device_property('Adapter')
    end
  end
end
