# frozen_string_literal: true

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
    LogActually.player
  end
end
