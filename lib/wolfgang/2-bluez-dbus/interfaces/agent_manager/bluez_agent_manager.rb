# frozen_string_literal: false

module Wolfgang
  # BluezAgentManager
  module BluezAgentManager
    def register_agent(object, string)
      interface(BLUEZ_AGENT_MANAGER).RegisterAgent(object, string)
    end
  end
end
