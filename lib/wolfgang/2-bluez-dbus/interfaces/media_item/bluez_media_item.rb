# frozen_string_literal: true

module Wolfgang
  # Bluez Interface: org.bluez.MediaItem1
  module BluezMediaItem
    include InterfaceConstants
    # METHODS
    # void Play()
    def play(item); end

    # void AddtoNowPlaying()
    def add_to_now_playing(item); end

    # PROPERTIES

    # object Player [readonly]
    # Player object path the item belongs to
    def player
      media_item_property('Player')
    end

    # string Name [readonly]
    # Item displayable name
    def name
      media_item_property('Name')

    end

    # string Type [readonly]
    # Item type
    # Possible values: "video", "audio", "folder"
    def type
      media_item_property('Type')
    end

    # string FolderType [readonly, optional]
    # Folder type.
    # Possible values: "mixed", "titles", "albums", "artists"
    # Available if property Type is "Folder"
    def folder_type
      media_item_property('FolderType')
    end

    # boolean Playable [readonly, optional]
    # Indicates if the item can be played
    # Available if property Type is "folder"
    def playable
      media_item_property('Playable')
    end

    # dict Metadata [readonly]
    # Item metadata.
    def meta_data
      media_item_property('Metadata')
    end

    def media_item
      self.default_iface = BLUEZ_MEDIA_ITEM
      @selected_interface = BLUEZ_MEDIA_ITEM
      self
    end

    private

    def media_item_property(property)
      property_get(BLUEZ_MEDIA_ITEM, property)
    end
  end
end
