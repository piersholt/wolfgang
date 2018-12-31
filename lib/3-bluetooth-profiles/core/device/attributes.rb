# frozen_string_literal: true

module Core
  class Device
    # Comment
    module Attributes
      # string Address [readonly]
      def address
        attributes['Address'] ||= object.address
      end

      # string AddressType [readonly]
      def address_type
        attributes['AddressType'] ||= object.address_type
      end

      # string Name [readonly, optional]
      # def name
      #   attributes['Name'] ||= object.name
      # end

      # string Icon [readonly, optional]
      def icon
        attributes['Icon'] ||= object.icon
      end

      # uint32 Class [readonly, optional]
      # def class
      #   attributes['Class'] ||= object.class
      # end

      # uint16 Appearance [readonly, optional]
      def appearance
        attributes['Appearance'] ||= object.appearance
      end

      # array{string} UUIDs [readonly, optional]
      def uuids
        attributes['{'] ||= object.uuids
      end

      # boolean Paired [readonly]
      def paired
        attributes['Paired'] ||= object.paired
      end

      # boolean Connected [readonly]
      def connected
        attributes['Connected'] ||= object.connected
      end

      # boolean Trusted [readwrite]
      def trusted
        attributes['Trusted'] ||= object.trusted
      end

      # boolean Blocked [readwrite]
      def blocked
        attributes['Blocked'] ||= object.blocked
      end

      # string Alias [readwrite]
      def alias
        attributes['Alias'] ||= object.alias
      end

      # object Adapter [readonly]
      def adapter
        attributes['Adapter'] ||= object.adapter
      end

      # boolean LegacyPairing [readonly]
      def legacy_pairing
        attributes['LegacyPairing'] ||= object.legacy_pairing
      end

      # string Modalias [readonly, optional]
      def modalias
        attributes['Modalias'] ||= object.modalias
      end

      # int16 RSSI [readonly, optional]
      def rssi
        attributes['RSSI'] ||= object.rssi
      end

      # int16 TxPower [readonly, optional]
      def tx_power
        attributes['TxPower'] ||= object.tx_power
      end

      # dict ManufacturerData [readonly, optional]
      def manufacturer_data
        attributes['ManufacturerData'] ||= object.manufacturer_data
      end

      # dict ServiceData [readonly, optional]
      def service_data
        attributes['ServiceData'] ||= object.service_data
      end

      # bool ServicesResolved [readonly]
      def services_resolved
        attributes['ServicesResolved'] ||= object.services_resolved
      end

      # array{byte} AdvertisingFlags [readonly, experimental]
      def advertising_flags
        attributes['{'] ||= object.advertising_flags
      end

      # dict AdvertisingData [readonly, experimental]
      def advertising_data
        attributes['AdvertisingData'] ||= object.advertising_data
      end

    end
  end
end
