# frozen_string_literal: true

# EVENT_AVAILABLE_PLAYERS_CHANGED
# The available players have changed

# EVENT_ADDRESSED_PLAYER_CHANGED
# The Addressed Player has been changed

# EVENT_UIDS_CHANGED
# The UIDs have changed

# EVENT_BATT_STATUS_CHANGED
# Change in battery status

# EVENT_SYSTEM_STATUS_CHANGED
# Change in system status

# EVENT_VOLUME_CHANGED

module Wolfgang
  module Bluetooth
    module Profile
      module AVRCP
        class Controller
          module Signals
            # Bluetooth Service: AVRCP Controller Signals
            module MediaControl
              include LogActually::ErrorOutput
              include Constants

              def media_control_properties_changed_block
                proc do |signal|
                  media_control_properties_changed(signal)
                end
              end

              def media_control_properties_changed(signal)
                logger.debug(MODULE_PROG) do
                  "#media_control_properties_changed(#{signal.changed}, #{signal.removed})"
                end

                case evaluate_media_control_properties(signal)
                when :added
                  target_added(signal)
                when :updated
                  target_changed(signal)
                when :removed
                  target_removed(signal)
                end
              rescue StandardError => e
                with_backtrace(logger, e)
              end

              def evaluate_media_control_properties(signal)
                if signal.connected? && signal.player?
                  :added
                elsif signal.player?
                  :updated
                elsif signal.disconnected? && signal.player_removed?
                  :removed
                elsif signal.disconnected? && signal.no_player?
                  :removed
                end
              end

              private

              def target_added(signal)
                logger.debug(MODULE_PROG) { PLAYER_ADDED }
                target_added!(signal)
              end

              def target_updated(signal)
                logger.debug(MODULE_PROG) { PLAYER_CHANGED }
                target_updated!(signal)
              end

              def target_removed(signal)
                logger.debug(MODULE_PROG) { PLAYER_REMOVED }
                target_removed!(signal)
              end
            end
          end
        end
      end
    end
  end
end
