# frozen_string_literal: true

# An API can optionally make use of this interface for one or more sub-trees
# of objects. The root of each sub-tree implements this interface so other
# applications can get all objects, interfaces and properties in a single
# method call. It is appropriate to use this interface if users of the tree
# of objects are expected to be interested in all interfaces of all objects in
# the tree; a more granular API should be used if users of the objects are
# expected to be interested in a small subset of the objects, a small subset of
# their interfaces, or both.
module ObjectManager
  OBJECT_MANAGER_INTERFACE = 'org.freedesktop.DBus.ObjectManager'

  def managed_objects
    result = object_manager_interface.GetManagedObjects
    # raise StandardError('get managed objects length is > 1') unless result.length == 1
    # result = result.first

    mapped_objects = result.map do |object, interfaces|
      object_interfaces = interfaces.keys
      object_interfaces.sort!
      [object, object_interfaces]
    end

    mapped_objects.sort! { |a, b| a[0] <=> b[0] }
    mapped_objects.to_h
  end

  # private

  def get_managed_objects
    object_manager_interface.GetManagedObjects
  end

  def object_manager_interface
    interface(OBJECT_MANAGER_INTERFACE)
  end

  # SIGNALS

  # InterfacesAdded
  # InterfacesRemoved
end
