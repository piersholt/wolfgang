# frozen_string_literal: true

module Wolfgang
  module BluezDevice
    # Properties of Bluez Interface: org.bluez.Device1
    module Properties
      include Constants

      # @return string  Address [readonly]
      def address
        device_property(ADDRESS)
      end

      # @return string  AddressType [readonly]
      def address_type
        device_property(ADDRESS_TYPE)
      end

      # @return string  Name [readonly, optional]
      def name
        device_property(NAME)
      end

      # @return string  Icon [readonly, optional]
      def icon
        device_property(ICON)
      end

      # @return uint32  Class [readonly, optional]
      def klass
        device_property(CLASS)
      end

      # @return uint16  Appearance [readonly, optional]
      def appearance
        device_property(APPEARANCE)
      end

      # @return   {string}   UUIDs [readonly, optional]
      def uuids
        device_property(UUIDS)
      end

      # @return boolean Paired [readonly]
      def paired
        device_property(PAIRED)
      end

      # @return boolean Connected [readonly]
      def connected
        device_property(CONNECTED)
      end

      # @return boolean Trusted [readwrite]
      def trusted
        device_property(TRUSTED)
      end

      # @return boolean Blocked [readwrite]
      def blocked
        device_property(BLOCKED)
      end

      # @return string  Alias [readwrite]
      def alias
        device_property(ALIAS)
      end

      # @return object  Adapter [readonly]
      def adapter
        device_property(ADAPTER)
      end

      # @return boolean LegacyPairing [readonly]
      def legacy_pairing
        device_property(LEGACY_PAIRING)
      end

      # @return string  Modalias [readonly, optional]
      def modalias
        device_property(MODALIAS)
      end

      # @return int16 RSSI [readonly, optional]
      def rssi
        device_property(RSSI)
      end

      # @return int16 TxPower [readonly, optional]
      def tx_power
        device_property(TX_POWER)
      end

      # @return dict  ManufacturerData [readonly, optional]
      def manufacturer_data
        device_property(MANUFACTURER_DATA)
      end

      # @return dict  ServiceData [readonly, optional]
      def service_data
        device_property(SERVICE_DATA)
      end

      # @return bool  ServicesResolved [readonly]
      def services_resolved
        device_property(SERVICES_RESOLVED)
      end

      # @return array{byte} AdvertisingFlags [readonly, experimental]
      def advertising_flags
        device_property(ADVERTISING_FLAGS)
      end

      # @return dict  AdvertisingData [readonly, experimental]
      def advertising_data
        device_property(ADVERTISING_DATA)
      end

      alias paired? paired
      alias connected? connected
      alias trusted? trusted
      alias blocked? blocked
      alias legacy_pairing? legacy_pairing
    end
  end
end
