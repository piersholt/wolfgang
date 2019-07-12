# frozen_string_literal: true

module Wolfgang
  # DevicePropertiesChanged
  class DevicePropertiesChanged < PropertiesChanged
    include InterfaceConstants

    CONNECTED = 'Connected'.to_sym.downcase
    PLAYER = 'Player'.to_sym.downcase

    def initialize(object, target, changed, removed)
      super(object, target, Hashify.symbolize(changed), Hashify.symbolize_array(removed))
    end

    # PROPERTIES

    # Media1 and MediaControl1
    def connected?
      is?(CONNECTED, true)
    end

    def disconnected?
      is?(CONNECTED, false)
    end

    # MediaControl1
    def player?
      has?(PLAYER)
    end

    def no_player?
      removed?(PLAYER) && !has?(PLAYER)
    end

    def player
      fetch(PLAYER)
    end
  end
end
