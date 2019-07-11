# frozen_string_literal: true

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
