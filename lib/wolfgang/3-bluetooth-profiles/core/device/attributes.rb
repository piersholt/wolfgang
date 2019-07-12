# frozen_string_literal: true

module Wolfgang
  module Core
    class Device
      # Attributes
      module Attributes
        ADDRESS = 'Address'.to_sym.downcase
        ADDRESS_TYPE = 'AddressType'.to_sym.downcase
        NAME = 'Name'.to_sym.downcase
        ICON = 'Icon'.to_sym.downcase
        CLASS = 'Class'.to_sym.downcase
        APPEARANCE = 'Appearance'.to_sym.downcase
        UUIDS = 'UUIDs'.to_sym.downcase
        PAIRED = 'Paired'.to_sym.downcase
        CONNECTED = 'Connected'.to_sym.downcase
        TRUSTED = 'Trusted'.to_sym.downcase
        BLOCKED = 'Blocked'.to_sym.downcase
        ALIAS = 'Alias'.to_sym.downcase
        ADAPTER = 'Adapter'.to_sym.downcase
        LEGACY_PAIRING = 'LegacyPairing'.to_sym.downcase
        MODALIAS = 'Modalias'.to_sym.downcase
        RSSI = 'RSSI'.to_sym.downcase
        TX_POWER = 'TxPower'.to_sym.downcase
        MANUFACTURER_DATA = 'ManufacturerData'.to_sym.downcase
        SERVICE_DATA = 'ServiceData'.to_sym.downcase
        SERVICES_RESOLVED = 'ServicesResolved'.to_sym.downcase
        ADVERTISING_FLAGS = 'AdvertisingFlags'.to_sym.downcase
        ADVERTISING_DATA = 'AdvertisingData'.to_sym.downcase

        # string Address [readonly]
        def address
          attributes[ADDRESS] ||= object.address
        end

        # string AddressType [readonly]
        def address_type
          attributes[ADDRESS_TYPE] ||= object.address_type
        end

        # string Name [readonly, optional]
        # def name
        #   attributes[NAME] ||= object.name
        # end

        # string Icon [readonly, optional]
        def icon
          attributes[ICON] ||= object.icon
        end

        # uint32 Class [readonly, optional]
        # def class
        #   attributes[CLASS] ||= object.class
        # end

        # uint16 Appearance [readonly, optional]
        def appearance
          attributes[APPEARANCE] ||= object.appearance
        end

        # array{string} UUIDs [readonly, optional]
        def uuids
          attributes[UUIDS] ||= object.uuids
        end

        # boolean Paired [readonly]
        def paired
          attributes[PAIRED] ||= object.paired
        end

        # boolean Connected [readonly]
        def connected
          attributes[CONNECTED] ||= object.connected
        end

        # boolean Trusted [readwrite]
        def trusted
          attributes[TRUSTED] ||= object.trusted
        end

        # boolean Blocked [readwrite]
        def blocked
          attributes[BLOCKED] ||= object.blocked
        end

        # string Alias [readwrite]
        def alias
          attributes[ALIAS] ||= object.alias
        end

        # object Adapter [readonly]
        def adapter
          attributes[ADAPTER] ||= object.adapter
        end

        # boolean LegacyPairing [readonly]
        def legacy_pairing
          attributes[LEGACY_PAIRING] ||= object.legacy_pairing
        end

        # string Modalias [readonly, optional]
        def modalias
          attributes[MODALIAS] ||= object.modalias
        end

        # int16 RSSI [readonly, optional]
        def rssi
          attributes[RSSI] ||= object.rssi
        end

        # int16 TxPower [readonly, optional]
        def tx_power
          attributes[TX_POWER] ||= object.tx_power
        end

        # dict ManufacturerData [readonly, optional]
        def manufacturer_data
          attributes[MANUFACTURER_DATA] ||= object.manufacturer_data
        end

        # dict ServiceData [readonly, optional]
        def service_data
          attributes[SERVICE_DATA] ||= object.service_data
        end

        # bool ServicesResolved [readonly]
        def services_resolved
          attributes[SERVICES_RESOLVED] ||= object.services_resolved
        end

        # array{byte} AdvertisingFlags [readonly, experimental]
        def advertising_flags
          attributes[ADVERTISING_FLAGS] ||= object.advertising_flags
        end

        # dict AdvertisingData [readonly, experimental]
        def advertising_data
          attributes[ADVERTISING_DATA] ||= object.advertising_data
        end

      end
    end
  end
end
