# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Player
      # AVRCP::Player::Constants
      module Constants
        # Attributes
        NAME = 'Name'
        STATUS = 'Status'
        REPEAT = 'Repeat'
        SHUFFLE = 'Shuffle'
        POSITION = 'Position'
        TRACK = 'Track'
        DEVICE = 'Device'
        DURATION = 'Duration'
        TRACK_NUMBER = 'TrackNumber'

        # Notifications
        TRACK_CHANGED = 'Track changed!'
        TRACK_STARTED = 'Track started!'
        TRACK_ENDED = 'Track ended!'
        POSITION_CHANGED = 'Position Update'
        STATUS_CHANGED = 'Playback Status changed'
        REPEAT_CHANGED = 'Repeat Method changed'
        SHUFFLE_CHANGED = 'Shuffle Method changed'
      end
    end
  end
end
