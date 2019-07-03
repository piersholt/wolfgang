# frozen_string_literal: false

module Wolfgang
  # BluezMediaControl
  module BluezMediaControl
    include InterfaceConstants
    # METHODS

    # @deprecated
    def play; end

    # @deprecated
    def pause; end

    # @deprecated
    def stop; end

    # @deprecated
    def next; end

    # @deprecated
    def previous; end

    # @deprecated
    def volume_up; end

    # @deprecated
    def volume_down; end

    # @deprecated
    def fast_forward; end

    # @deprecated
    def rewind; end

    # PROPERTIES

    # boolean Connected [readonly]
    def connected?
      media_control_property('Connected')
    end

    # object Player [readonly, optional]
    def player
      media_control_property('Player')
    end

    def media_control
      self.default_iface = BLUEZ_MEDIA_CONTROL
      @selected_interface = BLUEZ_MEDIA_CONTROL
      self
    end

    private

    def media_control_interface
      interface(BLUEZ_MEDIA_CONTROL)
    end

    def media_control_property(property)
      media_control_property(BLUEZ_MEDIA_CONTROL, property)
    end
  end
end
