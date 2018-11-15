# bluez_defaults.rb

# frozen_string_literal: true

BLUEZ_DEFAULTS = {
  service_name: 'org.bluez',
  bus_type: :system_bus,
  controller_default_address: 'B8:27:EB:E2:79:E7',
  controller_default_index: 1,
  device_default_address: '70:70:0D:11:CF:29'
}.freeze
