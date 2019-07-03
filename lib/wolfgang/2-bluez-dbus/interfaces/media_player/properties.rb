# frozen_string_literal: true

module Wolfgang
  # Bluez Interface: org.bluez.MediaPlayer1
  module BluezMediaPlayer
    # Comment
    module Properties
      def track
        media_player_property('Track')
      end

      # Playber object path
      def device
        media_player_property('Device')
      end

      # Name of player, i.e. Sptify
      def name
        media_player_property('Name')
      end

      # * Major Player Type
      # -- Audio
      # -- Video
      # -- Broadcast Audio
      # -- Broadcast Video
      def type
        media_player_property('Type')
      end

      # * Player Sub Type
      # -- Audio Book
      # -- Postcast
      def subtype
        media_player_property('Subtype')
      end

      # If present indicates the player can be browsed using MediaFolder interface.
      # @browseable
      def browseable
        media_player_property('Browseable')
      end

      # If present indicates the player can be searched using MediaFolder interface.
      # @searchable
      def searchable
        media_player_property('Searchable')
      end

      # Playlist object path.
      # @playlist
      def playlist
        media_player_property('Playlist')
      end

      # @Equalizer [readwrite]
      # Possible values: "off" or "on"
      def equalizer
        media_player_property('Equalizer')
      end

      # @Repeat [readwrite]
      # Possible values: "off", "singletrack", "alltracks" or "group"
      def repeat
        media_player_property('Repeat')
      end

      # @Shuffle [readwrite]
      # Possible values: "off", "alltracks" or "group"
      def shuffle
        media_player_property('Shuffle')
      end

      # @Scan [readwrite]
      # Possible values: "off", "alltracks" or "group"
      def scan
        media_player_property('Scan')
      end

      # @Status [readonly]
      # Possible status: "playing", "stopped", "paused", "forward-seek",
      # "reverse-seek" or "error"
      def status
        media_player_property('Status')
      end
    end
  end
end
