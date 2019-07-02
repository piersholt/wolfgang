# frozen_string_literal: false

LOAD_PATH_LOGGER.debug { '|-+ wolfgang' }

require_relative('wolfgang/dbus-decorator')
require_relative('wolfgang/bluez-dbus')
require_relative('wolfgang/bluez-manager')
require_relative('wolfgang/bluetooth-profiles')
require_relative('wolfgang/virtual-car-kit')
