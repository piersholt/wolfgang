# frozen_string_literal: true

# EVENT_PLAYBACK_STATUS_CHANGED (0x01): Change in playback status of the current track.

# EVENT_PLAYER_APPLICATION_SETTING_CHANGED (0x08): Change in player application setting
# EVENT_NOW_PLAYING_CONTENT_CHANGED (0x09)
# The content of the Now Playing list has changed, see Section 6.9.5.
#
# EVENT_TRACK_CHANGED (0x02): Change of current track
# EVENT_TRACK_REACHED_END (0x03): Reached end of a track
# EVENT_TRACK_REACHED_START (0x04): Reached start of a track
#
# EVENT_PLAYBACK_POS_CHANGED (0x05): Change in playback position. Returned after the specified playback notification change notification interval
# ￼￼￼￼TG has reached the registered playback Interval time Changed PLAY STATUS
# Changed Current Track
# Reached end or beginning of track

module Wolfgang
  module AVRCP
    class Player
      # Comment
      module SignalHandling
        def properties_changed(signal)
          LogActually.avrcp.debug(self.class.name) { 'player_properties_changed!' }
          attributes!(signal.changed)
          if signal.only_track? && signal.title?
            track_change(signal)
            # elsif signal.only_duration?
            # track ending, updating track that's starting
          elsif signal.duration? && !signal.title?
            track_duration(signal)
          elsif signal.only_position?
            track_position(signal)
          elsif signal.only_status?
            player_status(signal)
          elsif signal.only_repeat?
            player_repeat(signal)
          elsif signal.only_shuffle?
            player_shuffle(signal)
          end
        end

        def time(milliseconds)
          seconds = milliseconds / 1000
          seconds.divmod(60)
        end

        def track_change(signal)
          LogActually.avrcp.debug("#{self.class}#attributes!") { 'Track change!' }
          track_changed!
        end

        def track_duration(signal)
          LogActually.avrcp.debug("#{self.class}#attributes!") { "Duration: #{signal.changed}" }
        end

        def track_start(signal)
          LogActually.avrcp.debug("#{self.class}#attributes!") { 'Track start!' }
          track_started!
        end

        def track_end(signal)
          LogActually.avrcp.debug("#{self.class}#attributes!") { 'Track end!' }
          track_ended!
        end

        def track_end?(signal)
          delta =  duration - signal.position
          LogActually.avrcp.debug("#{self.class}#attributes!") { "#{time duration} - #{time signal.position} => #{delta}" }
          result = delta <= 1500
          LogActually.avrcp.debug("#{self.class}#attributes!") { "delta <= 1500 => #{result}" }
          result
        end

        def track_start?(signal)
          signal.position <= 1500
        end

        def track_position(signal)
          return track_start(signal) if track_start?(signal)
          return track_end(signal) if track_end?(signal)
          LogActually.avrcp.debug("#{self.class}#attributes!") { "Position: #{time signal.position}" }
          position!
        end

        def player_status(signal)
          LogActually.avrcp.debug("#{self.class}#attributes!") { signal.status }
          status!
        end

        def player_repeat(signal)
          LogActually.avrcp.debug("#{self.class}#attributes!") { signal.repeat }
          repeat!
        end

        def player_shuffle(signal)
          LogActually.avrcp.debug("#{self.class}#attributes!") { signal.shuffle }
          shuffle!
        end
      end
    end
  end
end
