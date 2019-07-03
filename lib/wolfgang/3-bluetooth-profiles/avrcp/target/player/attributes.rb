# frozen_string_literal: true

module Wolfgang
  module AVRCP
    class Player
      # Attributes
      module Attributes
        def name
          attributes['Name'] ||= object.name
        end

        def status
          attributes['Status'] ||= object.status
        end

        def reapt
          attributes['Repeat'] ||= object.reapt
        end

        def shuffle
          attributes['Shuffle'] ||= object.shuffle
        end

        def position
          attributes['Position'] ||= object.position
        end

        def track
          attributes['Track'] ||= object.track
        end

        # Track Attributes

        def duration
          track['Duration'] ||= object.track['Duration']
        end

        def track_number
          track['TrackNumber'] ||= object.track['TrackNumber']
        end
      end
    end
  end
end
