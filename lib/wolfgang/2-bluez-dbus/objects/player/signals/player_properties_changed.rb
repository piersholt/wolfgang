# frozen_string_literal: true

module Wolfgang
  # PlayerPropertiesChanged
  class PlayerPropertiesChanged < PropertiesChanged
    include InterfaceConstants

    PROG = 'PlayerPropertiesChanged'

    STATUS = 'Status'
    TRACK = 'Track'
    POSITION = 'Position'
    REPEAT = 'Repeat'
    SHUFFLE = 'Shuffle'
    TITLE = 'Title'
    NUMBER_OF_TRACKS = 'NumberOfTracks'
    DURATION = 'Duration'
    TITLE = 'Title'
    ARTIST = 'Artist'
    TRACK_NUMBER = 'TrackNumber'
    DEVICE = 'Device'

    def initialize(object, target, changed, removed)
      super
    end

    # INTERFACE

    def player?
      this_interface?(BLUEZ_MEDIA_PLAYER)
    end

    def folder?
      this_interface?(BLUEZ_MEDIA_FOLDER)
    end

    # PROPERTIES

    def track?
      has(TRACK)
    end

    def only_track?
      only?(TRACK)
    end

    def position?
      has(POSITION)
    end

    def only_position?
      only?(POSITION)
    end

    def only_status?
      only?(STATUS)
    end

    def status
      fetch(STATUS)
    end

    def track
      fetch(TRACK) || {}
    end

    def position
      fetch(POSITION)
    end

    def only_shuffle?
      only?(SHUFFLE)
    end

    def only_repeat?
      only?(REPEAT)
    end

    # alltracks, singletrack, off
    def repeat
      fetch(REPEAT)
    end

    # alltracks, off
    def shuffle
      fetch(SHUFFLE)
    end

    # TRACK

    def title?
      track[TITLE] ? true : false
    end

    def number_of_tracks?
      track[NUMBER_OF_TRACKS] ? true : false
    end

    def track_number?
      track[TRACK_NUMBER] ? true : false
    end

    def duration?
      track[DURATION] ? true : false
    end

    def title
      track[TITLE]
    end

    def artist
      track[ARTIST]
    end

    def track_number
      track[TRACK_NUMBER]
    end
  end
end
