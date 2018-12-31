# frozen_string_literal: true

module ObjectManager
  # Methods of DBUS Interface: org.freedesktop.DBus.ObjectManager
  module Methods
    include InterfaceConstants

    def get_managed_objects(super_response_callback = nil)
      # called(OBJECT_MANAGER, :get_managed_objects)
      return object_manager_interface.GetManagedObjects unless super_response_callback
      object_manager_interface.GetManagedObjects(&super_response_callback)
    end

    alias managed_objects get_managed_objects
  end
end
