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
      # AVRCP::Player::SignalHandling
      module SignalHandling
        MODULE_PROG = 'Player::SignalHandling'

        def properties_changed(signal)
          LogActually.avrcp.debug(MODULE_PROG) { "#properties_changed! (#{signal.class})" }
          attributes!(signal.changed)
        end
      end
    end
  end
end
