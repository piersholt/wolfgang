# frozen_string_literal: true

# Comment
class BluezRootObject < ObjectAdapter
  # include InterfaceConstants
  include Properties
  include ObjectManager

  include Callable

  def inspect
    self.class
  end

  def logger
    LogActually.object_manager
  end
end
