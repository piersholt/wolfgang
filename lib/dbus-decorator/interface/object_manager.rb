module ObjectManager
  OBJECT_MANAGER_INTERFACE = 'org.freedesktop.DBus.ObjectManager'.freeze

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
