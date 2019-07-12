# frozen_string_literal: true

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

module Wolfgang
  module AVRCP
    class Target
      # SignalHandling
      module SignalHandling
        include Constants
        
        MODULE_PROG = 'Target::SignalHandling'

        def media_control_callback
          proc do |signal|
            begin
              properties_changed(signal)
            rescue StandardError => e
              LogActually.avrcp.error(MODULE_PROG) { e }
            end
          end
        end

        def media_player_callback
          proc do |signal|
            begin
              addressed_player.properties_changed(signal)
            rescue StandardError => e
              LogActually.avrcp.error(MODULE_PROG) { e }
            end
          end
        end

        def properties_changed(signal)
          LogActually.avrcp.debug(MODULE_PROG) { "#properties_changed! (#{signal.class})" }
          if signal.connected? && signal.player?
            player_added(signal)
          elsif signal.player?
            player_changed(signal)
          elsif signal.disconnected? && signal.no_player?
            player_removed
          end
        rescue StandardError => e
          LogActually.avrcp.error(MODULE_PROG) { e }
          e.backtrace.each do|line|
            LogActually.avrcp.error(MODULE_PROG) { line }
          end
        end

        def player_added(signal)
          LogActually.avrcp.debug(MODULE_PROG) { PLAYER_ADDED }
          add_player(signal.player)
          player_added!
        end

        def player_changed(signal)
          LogActually.avrcp.debug(MODULE_PROG) { PLAYER_CHANGED }
          add_player(signal.player)
          player_changed!
        end

        def player_removed
          LogActually.avrcp.debug(MODULE_PROG) { PLAYER_REMOVED }
          remove_player
          player_removed!
        end
      end
    end
  end
end
