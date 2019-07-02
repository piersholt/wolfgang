# frozen_string_literal: true

LOAD_PATH_LOGGER.debug { 'Loading wolfgang/bluetooth_profiles/avrcp' }

# PLAYER
require_relative 'avrcp/target/player/attributes'
require_relative 'avrcp/target/player/notifications'
require_relative 'avrcp/target/player/signal_handling'
require_relative 'avrcp/target/player/state'
require_relative 'avrcp/target/player/player'

# TARGET
require_relative 'avrcp/target/target/commands'
require_relative 'avrcp/target/target/notifications'
require_relative 'avrcp/target/target/signal_handling'
require_relative 'avrcp/target/target/target'

require_relative 'avrcp/target_role'
