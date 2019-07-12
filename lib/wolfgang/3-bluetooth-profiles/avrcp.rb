# frozen_string_literal: true

puts 'wolfgang/bluetooth_profiles/avrcp'

# PLAYER
require_relative 'avrcp/target/player/player'

# TARGET
require_relative 'avrcp/target/commands'
require_relative 'avrcp/target/notifications'
require_relative 'avrcp/target/signal_handling'
require_relative 'avrcp/target/target'

require_relative 'avrcp/target_role'
