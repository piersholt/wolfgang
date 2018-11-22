class DevicePropertiesChanged < PropertiesChanged
  include InterfaceConstants

  def device_changes?
    target == BLUEZ_DEVICE
  end

  def media?
    target == BLUEZ_MEDIA_CONTROL
  end

  def has?(property)
    return false unless changed.key?(property)
  end

  def is?(property, value)
    return false unless changed.key?(property)
    @changed[property] == value
  end

  def connected?
    is?('Connected', true)
  end

  def player?
    has?('Player')
  end

  def player
    changed['Player']
  end
end
