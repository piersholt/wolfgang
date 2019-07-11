# frozen_string_literal: true

module Wolfgang
  # BluezRootObject
  class BluezRootObject < ObjectAdapter
    include Properties
    include ObjectManager

    include Callable

    def inspect
      self.class
    end

    def logger
      LogActually.object_root
    end
  end
end
