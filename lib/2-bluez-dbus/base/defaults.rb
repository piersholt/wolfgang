# bluez_defaults.rb

# frozen_string_literal: true

module BluezDBusConfig
  BUS_TYPE = :system_bus
  SERVICE_NAME = 'org.bluez'
end

module BluezServiceDefaults
  # CONTROLLER_ADDRESS = 'B8:27:EB:E2:79:E7'
  DEFAULT_CONTROLLER_INDEX = 1

  # DEVICE_ADDRESS = '70:70:0D:11:CF:29'

  IPHONE_7 = '/org/bluez/hci1/dev_70_70_0D_11_CF_29'
  IPHONE_5 = '/org/bluez/hci1/dev_4C_8D_79_8C_A0_94'
  IPAD     = '/org/bluez/hci1/E0_F5_C6_07_55_B3'
end
