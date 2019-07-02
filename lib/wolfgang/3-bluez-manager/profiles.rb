# frozen_string_literal: true

LOAD_PATH_LOGGER.debug { 'wolfgang/bluez-manager/profiles' }

module Profiles; end

require_relative 'profiles/a2dp'
require_relative 'profiles/avrcp'
require_relative 'profiles/other'

require_relative 'profiles/uuids'
