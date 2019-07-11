# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Target
      # Attributes
      module Attributes
        MODULE_PROG = 'Target::Attributes'

        PLAYER = 'Name'
        CONNECTED = 'Status'

        def attributes
          @attributes ||= { PLAYER => nil, CONNECTED => nil}
        end

        def player
          attributes[PLAYER]
        end

        def connected
          attributes[CONNECTED]
        end

        def attributes!(changes)
          LogActually.avrcp.unknown(MODULE_PROG) { "#attributes(#{changes})" }
          attributes.merge!(changes) do |_, old, new|
            old.instance_of?(Hash) ? squish(old, new) : new
          end
        end

        def squish(old, new)
          old.merge(new)
        end
      end
    end
  end
end
