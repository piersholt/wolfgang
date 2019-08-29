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
            module MediaPlayer
              include LogActually::ErrorOutput
              include Constants

              def media_player_properties_changed_block
                proc do |signal|
                  media_player_properties_changed(signal)
                end
              end

              def media_player_properties_changed(signal)
                logger.debug(MODULE_PROG) do
                  "#media_player_properties_changed(#{signal.class})"
                end

                player_references.merge!(signal.path => service.player_object(signal.path))

                case evaluate_media_player_properties(signal)
                when :track_start
                  notify!(:track_start, signal)
                when :track_pending
                  @duration = signal.duration if signal.duration?
                  notify!(:track_pending, signal)
                when :track_change
                  @duration = signal.duration if signal.duration?
                  notify!(:track_change, signal)
                when :track_end
                  notify!(:track_end, signal)
                when :status
                  notify!(:status, signal)
                when :position
                  notify!(:position, signal)
                when :created
                  @duration = signal.duration if signal.duration?
                  notify!(:created, signal)
                when :updated
                  notify!(:updated, signal)
                end
              rescue StandardError => e
                with_backtrace(logger, e)
              end

              START_MAX = 1500

              def duration
                @duration ||= 0
              end

              # Manual vs. Duration track change.
              # When manually changing tracks, the staged track duration will be 0,
              # and the position update used to determine if a track is nearing duration,
              # will also be 0.
              # As position will commonly be >= ~180ms when a track starts, if position
              # and duration is zero, this is evaluated as track_end.
              def evaluate_media_player_properties(signal)
                result =
                  if signal.only_position? && (128..START_MAX).cover?(signal.position)
                    :track_start
                  elsif signal.only_position? && signal.position.zero? && signal.position == duration
                    :track_end
                  elsif signal.only_position? && (0..127).cover?(signal.position)
                    :track_end
                  elsif signal.only_position? && duration.zero?
                    :track_start
                  elsif signal.only_position? && (duration - signal.position) <= START_MAX
                    :track_end
                  elsif signal.only_position?
                    :position
                  elsif signal.only_track? && signal.title?
                    :track_pending
                  elsif signal.only_track? && signal.duration?
                    :track_change
                  elsif signal.only_status?
                    :status
                  elsif signal.device?
                    :created
                  elsif signal.name?
                    :created
                  else
                    :updated
                  end
                logger.debug(MODULE_PROG) do
                  "#evaluate_media_player_properties => :#{result}"
                end
                result
              end
            end
          end
        end
      end
    end
  end
end
