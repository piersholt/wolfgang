# frozen_string_literal: true

# Bluez Player Object
class BluezPlayerObject < ObjectAdapter
  include Properties

  include BluezMediaFolder
  include BluezMediaPlayer

  def inspect
    self.class
  end

  def name
    'BluezPlayerObject'
  end

  def logger
    LogActually.media_player
  end
end