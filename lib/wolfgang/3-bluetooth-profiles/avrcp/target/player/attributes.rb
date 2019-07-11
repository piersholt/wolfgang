# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Player
      # Attributes
      module Attributes
        MODULE_PROG = 'Player::Attributes'

        NAME = 'Name'
        STATUS = 'Status'
        REPEAT = 'Repeat'
        SHUFFLE = 'Shuffle'
        POSITION = 'Position'
        TRACK = 'Track'
        DEVICE = 'Device'

        def attributes
          @attributes ||= {}
        end

        def name
          attributes[NAME] ||= object.name
        end

        def status
          attributes[STATUS] ||= object.status
        end

        def repeat
          attributes[REPEAT] ||= object.repeat
        end

        def shuffle
          attributes[SHUFFLE] ||= object.shuffle
        end

        def position
          attributes[POSITION] ||= object.position
        end

        def track
          attributes[TRACK] ||= object.track
        end

        def device
          attributes[DEVICE] ||= object.device
        end

        # Track Attributes

        def duration
          track['Duration'] ||= object.track['Duration']
        end

        def track_number
          track['TrackNumber'] ||= object.track['TrackNumber']
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
