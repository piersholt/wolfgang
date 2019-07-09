# frozen_string_literal: true

module Wolfgang
  module BluezDevice
    # Properties of Bluez Interface: org.bluez.Device1
    module Properties
      include Constants

      def connected
        device_property(CONNECTED)
      end

      def paired
        device_property(PAIRED)
      end

      def name
        device_property(NAME)
      end

      def address
        device_property(ADDRESS)
      end

      def klass
        device_property(CLASS)
      end

      def uuids
        device_property(UUIDS)
      end

      def trusted
        device_property(TRUSTED)
      end

      def blocked
        device_property(BLOCKED)
      end

      def alias
        device_property(ALIAS)
      end

      def adapter
        device_property(ADAPTER)
      end

      def icon
        device_property(ICON)
      end

      alias connected? connected
      alias paired? paired
      alias trusted? trusted
      alias blocked? blocked
    end
  end
end
