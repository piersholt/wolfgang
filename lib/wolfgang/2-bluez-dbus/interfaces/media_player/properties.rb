# frozen_string_literal: true

module Wolfgang
  # Bluez Interface: org.bluez.MediaPlayer1
  module BluezMediaPlayer
    # Comment
    module Properties
      include Constants

      def track
        media_player_property(TRACK)
      end

      # Playber object path
      def device
        media_player_property(DEVICE)
      end

      # Name of player, i.e. Sptify
      def name
        media_player_property(NAME)
      end

      # * Major Player Type
      # -- Audio
      # -- Video
      # -- Broadcast Audio
      # -- Broadcast Video
      def type
        media_player_property(TYPE)
      end

      # * Player Sub Type
      # -- Audio Book
      # -- Postcast
      def subtype
        media_player_property(SUBTYPE)
      end

      # If present indicates the player can be browsed using MediaFolder interface.
      # @browseable
      def browseable
        media_player_property(BROWSEABLE)
      end

      # If present indicates the player can be searched using MediaFolder interface.
      # @searchable
      def searchable
        media_player_property(SEARCHABLE)
      end

      # Playlist object path.
      # @playlist
      def playlist
        media_player_property(PLAYLIST)
      end

      # @Equalizer [readwrite]
      # Possible values: "off" or "on"
      def equalizer
        media_player_property(EQUALIZER)
      end

      # @Repeat [readwrite]
      # Possible values: "off", "singletrack", "alltracks" or "group"
      def repeat
        media_player_property(REPEAT)
      end

      # @Shuffle [readwrite]
      # Possible values: "off", "alltracks" or "group"
      def shuffle
        media_player_property(SHUFFLE)
      end

      # @Scan [readwrite]
      # Possible values: "off", "alltracks" or "group"
      def scan
        media_player_property(SCAN)
      end

      # @Status [readonly]
      # Possible status: "playing", "stopped", "paused", "forward-seek",
      # "reverse-seek" or "error"
      def status
        media_player_property(STATUS)
      end
    end
  end
end
