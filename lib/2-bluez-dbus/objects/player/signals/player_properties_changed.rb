# frozen_string_literal: true

class PlayerPropertiesChanged < PropertiesChanged
  include InterfaceConstants

  def initialize(object, target, changed, removed)
    super
  end

  # INTERFACE

  def player?
    this_interface?(BLUEZ_MEDIA_PLAYER)
  end

  def folder?
    this_interface?(BLUEZ_MEDIA_FOLDER)
  end

  # PROPERTIES

  def track?
    has('Track')
  end

  def only_track?
    only?('Track')
  end

  def position?
    has('Position')
  end

  def only_position?
    only?('Position')
  end

  def only_status?
    only?('Status')
  end

  def status
    fetch('Status')
  end

  def track
    fetch('Track')
  end

  def title
    fetch('Track')['Title']
  end

  def title?
    fetch('Track')['Title'] ? true : false
  end

  def artist
    fetch('Track')['Artist']
  end

  def position
    fetch('Position')
  end

  def only_shuffle?
    only?('Shuffle')
  end

  def only_repeat?
    only?('Repeat')
  end

  # alltracks, singletrack, off
  def repeat
    fetch('Repeat')
  end

  # alltracks, off
  def shuffle
    fetch('shuffle')
  end
end
