# frozen_string_literal: false

module Wolfgang
  # Bluez Core Object
  class BluezCoreObject < ObjectAdapter
    include BluezAgentManager
    include BluezHealthManager
    include BluezProfileManager
  end
end
