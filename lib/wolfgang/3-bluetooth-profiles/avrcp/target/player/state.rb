# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Player
      # State
      module State
        MODULE_PROG = 'Player::State'
        
        def attributes
          @attributes ||= {}
        end

        def squish(old, new)
          old.merge(new)
        end

        def attributes!(changes)
          LogActually.avrcp.unknown(MODULE_PROG) { "#attributes(#{changes})" }
          attributes.merge!(changes) do |_, old, new|
            old.instance_of?(Hash) ? squish(old, new) : new
          end
        end
      end
    end
  end
end
