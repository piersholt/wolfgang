# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Player
      # AVRCP::Player::Constants
      module Constants
        # Attributes
        NAME = 'Name'.to_sym.downcase
        STATUS = 'Status'.to_sym.downcase
        REPEAT = 'Repeat'.to_sym.downcase
        SHUFFLE = 'Shuffle'.to_sym.downcase
        POSITION = 'Position'.to_sym.downcase
        TRACK = 'Track'.to_sym.downcase
        DEVICE = 'Device'.to_sym.downcase
        DURATION = 'Duration'.to_sym.downcase
        TRACK_NUMBER = 'TrackNumber'.to_sym.downcase

        # Notifications
        TRACK_CHANGED = 'Track changed!'
        TRACK_STARTED = 'Track started!'
        TRACK_ENDED = 'Track ended!'
        POSITION_CHANGED = 'Position Update'
        STATUS_CHANGED = 'Playback Status changed'
        REPEAT_CHANGED = 'Repeat Method changed'
        SHUFFLE_CHANGED = 'Shuffle Method changed'
        PLAYER_CHANGED = 'Attributes changed'
      end
    end
  end
end
