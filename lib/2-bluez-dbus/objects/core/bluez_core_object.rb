# frozen_string_literal: false

# Bluez Core Object
class BluezCoreObject < ObjectAdapter
  include BluezAgentManager
  include BluezHealthManager
  include BluezProfileManager
end
