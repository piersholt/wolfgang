# frozen_string_literal: true

class BluezPlayerObject < ObjectAdapter
  include Properties

  include BluezMediaFolder
  include BluezMediaPlayer

  def inspect
    self.class
  end
end
