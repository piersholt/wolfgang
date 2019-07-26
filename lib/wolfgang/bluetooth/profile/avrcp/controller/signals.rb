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

require_relative 'signals/media_control'
require_relative 'signals/media_player'

module Wolfgang
  module Bluetooth
    module Profile
      module AVRCP
        class Controller
          # Bluetooth Service: AVRCP Controller Signals
          module Signals
            MODULE_PROG = 'Controller::Signals'

            include MediaControl
            include MediaPlayer
          end
        end
      end
    end
  end
end
