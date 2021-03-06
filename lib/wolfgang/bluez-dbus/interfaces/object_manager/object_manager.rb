# frozen_string_literal: true

module Wolfgang
  # An API can optionally make use of this interface for one or more sub-trees
  # of objects. The root of each sub-tree implements this interface so other
  # applications can get all objects, interfaces and properties in a single
  # method call. It is appropriate to use this interface if users of the tree
  # of objects are expected to be interested in all interfaces of all objects in
  # the tree; a more granular API should be used if users of the objects are
  # expected to be interested in a small subset of the objects, a small subset of
  # their interfaces, or both.
  module ObjectManager
    include InterfaceConstants
    include Methods
    include Signals

    def logger
      LogActually.interface_object_manager
    end

    def object_manager
      self.default_iface = OBJECT_MANAGER
      @selected_interface = OBJECT_MANAGER
      self
    end

    private

    def object_manager_interface
      interface(OBJECT_MANAGER)
    end
  end
end
