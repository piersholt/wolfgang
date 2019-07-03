# frozen_string_literal: true

module Wolfgang
  # Bluez Interface: org.bluez.MediaFolder1
  module BluezMediaFolder
    include InterfaceConstants

    DEFAULT_FILTER =
      {
        'Start': 0,
        # 'End': number_of_items,
        'Attributes':
          [
            'title', 'artist', 'album', 'genre',
            'number-of-tracks', 'number', 'duration'
          ]
      }.freeze
    # METHODS
    # object Search(string value, dict filter)
    def search(value, filter)
      media_folder_interface.Search(value, filter)
    end

    # array{objects, properties} ListItems(dict filter)
    def list_items(filter = DEFAULT_FILTER)
      media_folder_interface.ListItems(filter)
    end

    # void ChangeFolder(object folder)
    def change_foler(folder)
      media_folder_interface.ChangeFolder(folder)
    end

    # PROPERTIES

    # uint32 NumberOfItems [readonly]
    def number_of_items
      media_folder_property('NumberOfItems')
    end

    # string Name [readonly]
    def name
      media_folder_property('Name')
    end

    # ---------

    def media_folder
      self.default_iface = BLUEZ_MEDIA_FOLDER
      @selected_interface = BLUEZ_MEDIA_FOLDER
      self
    end

    private

    def media_folder_interface
      interface(BLUEZ_MEDIA_FOLDER)
    end

    def media_folder_property(property)
      property_get(BLUEZ_MEDIA_FOLDER, property)
    end
  end
end
