# frozen_string_literal: true

module Wolfgang
  module Bluetooth
    module Profile
      module AVRCP
        class Controller
          # AVRCP::Controller::Constants
          module Constants
            PROG = 'AVRCP::Controller'

            # Attributes
            PLAYER = 'Player'.to_sym.downcase
            CONNECTED = 'Connected'.to_sym.downcase

            # Signals & Notifications
            PLAYER_ADDED = 'Player added!'
            PLAYER_CHANGED = 'Player changed!'
            PLAYER_REMOVED = 'Player removed!'

            def logger
              LogActually.bt_ct
            end
          end
        end
      end
    end
  end
end
