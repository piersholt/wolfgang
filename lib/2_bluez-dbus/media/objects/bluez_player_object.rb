# frozen_string_literal: true

class BluezPlayerObject < ObjectAdapter
  include Properties

  include BluezMediaPlayer
  include BluezMediaFolder
end
