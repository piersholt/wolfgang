# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Target
      # AVRCP::Target::Constants
      module Constants
        # Attributes
        PLAYER = 'Name'
        CONNECTED = 'Status'

        # Signals & Notifications
        PLAYER_ADDED = 'Player added!'
        PLAYER_CHANGED = 'Player changed!'
        PLAYER_REMOVED = 'Player removed!'
      end
    end
  end
end
