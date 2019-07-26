# frozen_string_literal: true

module Wolfgang
  # ObjectManager
  module ObjectManager
    # Methods of DBUS Interface: org.freedesktop.DBus.ObjectManager
    module Methods
      include InterfaceConstants

      PROG = 'Interface::ObjectManager'

      def get_managed_objects(&block)
        logger.debug(PROG) { "#get_managed_objects(#{block ? true : false})" }
        object_manager_interface.GetManagedObjects(&block)
      end

      alias managed_objects get_managed_objects
    end
  end
end
