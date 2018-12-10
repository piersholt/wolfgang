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

module AVRCP
  class Player
    # Comment
    module SignalHandling
      def properties_changed(signal)
        if signal.only_track? && signal.title?
          track_change(signal)
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
        LOGGER.unknown("#{self.class}#attributes!") { 'Track change!' }
        attributes!(signal.changed)
        track_changed!
      end

      def track_duration(signal)
        LOGGER.unknown("#{self.class}#attributes!") { "Duration: #{signal.changed}" }
        attributes!(signal.changed)
      end

      def track_start(signal)
        LOGGER.unknown("#{self.class}#attributes!") { 'Track start!' }
        attributes!(signal.changed)
        track_started!
      end

      def track_end(signal)
        LOGGER.unknown("#{self.class}#attributes!") { 'Track end!' }
        attributes!(signal.changed)
        track_ended!
      end

      def track_end?(signal)
        delta = signal.position - duration
        LOGGER.unknown("#{self.class}#attributes!") { "#{time signal.position} - #{time duration} => #{delta}" }
        result = delta >= 0
        LOGGER.unknown("#{self.class}#attributes!") { "delta >= 0 => #{result}" }
        result
      end

      def track_start?(signal)
        signal.position <= 1500
      end

      def track_position(signal)
        return track_start(signal) if track_start?(signal)
        return track_end(signal) if track_end?(signal)
        LOGGER.unknown("#{self.class}#attributes!") { "Position: #{time signal.position}" }
        attributes!(signal.changed)
        position!
      end

      def player_status(signal)
        LOGGER.unknown("#{self.class}#attributes!") { signal.status }
        attributes!(signal.changed)
        status!
      end

      def player_repeat(signal)
        LOGGER.unknown("#{self.class}#attributes!") { signal.repeat }
        attributes!(signal.changed)
        repeat!
      end

      def player_shuffle(signal)
        LOGGER.unknown("#{self.class}#attributes!") { signal.shuffle }
        attributes!(signal.changed)
        shuffle!
      end
    end
  end
end
