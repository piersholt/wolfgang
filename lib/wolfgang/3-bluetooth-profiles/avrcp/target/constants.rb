# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Target
      # AVRCP::Target::Constants
      module Constants
        # Attributes
        PLAYER = 'Player'.to_sym.downcase
        CONNECTED = 'Connected'.to_sym.downcase

        # Signals & Notifications
        PLAYER_ADDED = 'Player added!'
        PLAYER_CHANGED = 'Player changed!'
        PLAYER_REMOVED = 'Player removed!'
      end
    end
  end
end
