# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Target
      # SignalHandling
      module SignalHandling
        MODULE_PROG = 'Target::SignalHandling'
        PLAYER_AVAILABLE = 'Player available!'
        PLAYER_CHANGED = 'Player changed!'
        PLAYER_REMOVED = 'Player removed!'

        def target_control_callback
          proc do |signal|
            begin
              control_properties_changed(signal)
            rescue StandardError => e
              LogActually.avrcp.error(MODULE_PROG) { e }
            end
          end
        end

        def addressed_player_callback
          proc do |signal|
            begin
              addressed_player.properties_changed(signal)
            rescue StandardError => e
              LogActually.avrcp.error(MODULE_PROG) { e }
            end
          end
        end

        alias player_callback addressed_player_callback

        def control_properties_changed(signal)
          LogActually.avrcp.debug(MODULE_PROG) { '#control_properties_changed! (#{signal.class})' }
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
          LogActually.avrcp.debug(MODULE_PROG) { PLAYER_AVAILABLE }
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
