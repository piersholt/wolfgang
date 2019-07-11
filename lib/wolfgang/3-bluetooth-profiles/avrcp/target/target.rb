# frozen_string_literal: true

# @addressed_player
# EVENT_AVAILABLE_PLAYERS_CHANGED (0x0a):
# The available players have changed, see Section 6.9.4.

# ￼￼￼￼EVENT_ADDRESSED_PLAYER_CHANGED (0x0b):
# The Addressed Player has been changed, see Section 6.9.2.

# @browsed_player

# EVENT_UIDS_CHANGED (0x0c):
# The UIDs have changed, see Section 6.10.3.3.

# @battery_status
# EVENT_BATT_STATUS_CHANGED (0x06):
# Change in battery status

# @system_status
# ￼EVENT_SYSTEM_STATUS_CHANGED (0x07):
# Change in system status

# @volume
# EVENT_VOLUME_CHANGED (0x0d)

require_relative 'attributes'

module Wolfgang
  module AVRCP
    # Target
    class Target
      include Attributes
      include SignalHandling
      include Notifications
      include Commands

      attr_reader :addressed_player, :browsed_player,
      :battery_status, :system_status, :volume

      PROG = 'AVRCP::Target'

      alias player addressed_player

      def initialize
        @addressed_player = nil
        @browsed_player = nil

        @battery_status = nil
        @system_status = nil

        @volume = 50
      end

      def add_player(player_path)
        LogActually.avrcp.debug(PROG) { "#add_player(#{player_path})" }
        new_player = Player.new(player_path)
        new_player.notifications_queue = notifications_queue
        @addressed_player = new_player
      end

      def remove_player
        @addressed_player = nil
      end
    end
  end
end
