# frozen_string_literal: true

module Wolfgang
  module BluezDevice
    # Constants for Bluez Interface: org.bluez.Device1
    module Constants
      PROG = 'Interface::Device'

      ADDRESS           = 'Address'
      ADDRESS_TYPE      = 'AddressType'
      NAME              = 'Name'
      ICON              = 'Icon'
      CLASS             = 'Class'
      APPEARANCE        = 'Appearance'
      UUIDS             = 'UUIDs'
      PAIRED            = 'Paired'
      CONNECTED         = 'Connected'
      TRUSTED           = 'Trusted'
      BLOCKED           = 'Blocked'
      ALIAS             = 'Alias'
      ADAPTER           = 'Adapter'
      LEGACY_PAIRING    = 'LegacyPairing'
      MODALIAS          = 'Modalias'
      RSSI              = 'RSSI'
      TX_POWER          = 'TxPower'
      MANUFACTURER_DATA = 'ManufacturerData'
      SERVICE_DATA      = 'ServiceData'
      SERVICES_RESOLVED = 'ServicesResolved'
      ADVERTISING_FLAGS = 'AdvertisingFlags'
      ADVERTISING_DATA  = 'AdvertisingData'
    end
  end
end
