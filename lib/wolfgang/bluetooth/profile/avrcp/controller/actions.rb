# frozen_string_literal: true

module Wolfgang
  module Bluetooth
    module Profile
      module AVRCP
        class Controller
          # AVRCP::Controller::Actions
          module Actions
            include Constants

            def forward(command, path)
              logger.warn(PROG) { "#forward(#{command}, #{path})" }
              service.player_object(path)&.public_send(command)
            end

            alias route forward
          end
        end
      end
    end
  end
end
