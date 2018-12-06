# frozen_string_literal: true

class DevicePropertiesChanged < PropertiesChanged
  include InterfaceConstants

  def initialize(object, target, changed, removed)
    super
  end

  # PROPERTIES

  def connected?
    is?('Connected', true)
  end

  def disconnected?
    is?('Connected', false)
  end

  def player?
    has?('Player')
  end

  def no_player?
    removed?('Player') && !has?('Player')
  end

  # PROPERTIES

  def player
    fetch('Player')
  end
end
