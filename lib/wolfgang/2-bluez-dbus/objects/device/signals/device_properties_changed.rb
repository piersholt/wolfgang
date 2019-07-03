# frozen_string_literal: true

module Wolfgang
  # DevicePropertiesChanged
  class DevicePropertiesChanged < PropertiesChanged
    include InterfaceConstants

    def initialize(object, target, changed, removed)
      super
    end

    # PROPERTIES

    # Media1 and MediaControl1
    def connected?
      is?('Connected', true)
    end

    def disconnected?
      is?('Connected', false)
    end

    # MediaControl1
    def player?
      has?('Player')
    end

    def no_player?
      removed?('Player') && !has?('Player')
    end

    def player
      fetch('Player')
    end
  end
end
