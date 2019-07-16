# frozen_string_literal: false

module Wolfgang
  # Bluez Core Objec
  # Path: /org/bluez
  class BluezCoreObject < ObjectAdapter
    include BluezAgentManager
    include BluezHealthManager
    include BluezProfileManager
  end
end
