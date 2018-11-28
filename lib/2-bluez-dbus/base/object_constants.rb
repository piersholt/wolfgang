# frozen_string_literal: true

module ObjectConstants
  ROOT_OBJECT_PATH = '/'
  CORE_OBJECT_PATH = '/org/bluez'
  CONTROLLER_OBJECT_PATH = '/org/bluez/hci'

  CONTROLLER_OBJECT_PREFIX = '/hci'
  DEVICE_OBJECT_PREFIX = '/dev_'
  MEDIA_TRANSPORT_OBJECT_PREFIX = '/fd'
  PLAYER_OBJECT_PREFIX = '/player'

  CONTROLLER_OBJECT_PATTERN = %r{hci\d{1,2}(?!\/)}
  DEVICE_OBJECT_PATTERN = %r{\/dev_[0-9A-F_]+\Z}
  MEDIA_TRANSPORT_OBJECT_PATTERN = %r{\/fd\d+\Z}
  PLAYER_OBJECT_PATTERN = %r{\/player\d+\Z}
end
