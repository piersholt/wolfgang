# frozen_string_literal: true

module Wolfgang
  # PlayerPropertiesChanged
  class PlayerPropertiesChanged < PropertiesChanged
    include InterfaceConstants

    PROG = 'PlayerPropertiesChanged'

    NAME = 'Name'.to_sym.downcase
    TYPE = 'Type'.to_sym.downcase
    STATUS = 'Status'.to_sym.downcase
    POSITION = 'Position'.to_sym.downcase
    SHUFFLE = 'Shuffle'.to_sym.downcase
    REPEAT = 'Repeat'.to_sym.downcase
    DEVICE = 'Device'.to_sym.downcase
    TRACK = 'Track'.to_sym.downcase

    TITLE = 'Title'.to_sym.downcase
    ARTIST = 'Artist'.to_sym.downcase
    TRACK_NUMBER = 'TrackNumber'.to_sym.downcase
    NUMBER_OF_TRACKS = 'NumberOfTracks'.to_sym.downcase
    DURATION = 'Duration'.to_sym.downcase

    def initialize(object, target, changed, removed)
      super(object, target, Hashify.symbolize(changed), Hashify.symbolize_array(removed))
    end

    # INTERFACE

    def player?
      this_interface?(BLUEZ_MEDIA_PLAYER)
    end

    def folder?
      this_interface?(BLUEZ_MEDIA_FOLDER)
    end

    # PROPERTIES

    def name
      fetch(NAME)
    end

    def type
      fetch(TYPE)
    end

    def status
      fetch(STATUS)
    end

    def position
      fetch(POSITION)
    end

    def repeat
      fetch(REPEAT)
    end

    def shuffle
      fetch(SHUFFLE)
    end

    def device
      fetch(DEVICE)
    end

    def track
      fetch(TRACK) || {}
    end

    # PLAYER HAS

    def name?
      has?(NAME)
    end

    def position?
      has?(POSITION)
    end

    def device?
      has?(DEVICE)
    end

    def track?
      has?(TRACK)
    end

    # PLAYER ONLY

    def only_status?
      only?(STATUS)
    end

    def only_position?
      only?(POSITION)
    end

    def only_shuffle?
      only?(SHUFFLE)
    end

    def only_repeat?
      only?(REPEAT)
    end

    def only_track?
      only?(TRACK)
    end

    # TRACK

    def title
      track[TITLE]
    end

    def artist
      track[ARTIST]
    end

    def track_number
      track[TRACK_NUMBER]
    end

    def duration
      track[DURATION]
    end

    # TRACK HAS

    def title?
      track[TITLE] ? true : false
    end

    def track_number?
      track[TRACK_NUMBER] ? true : false
    end

    def number_of_tracks?
      track[NUMBER_OF_TRACKS] ? true : false
    end

    def duration?
      track[DURATION] ? true : false
    end
  end
end
