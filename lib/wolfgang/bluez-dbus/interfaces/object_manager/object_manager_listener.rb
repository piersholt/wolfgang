# frozen_string_literal: true

module Wolfgang
  # ObjectManagerListener
  module ObjectManagerListener
    INTERFACES_ADDED = 'InterfacesAdded'
    INTERFACES_REMOVED = 'InterfacesRemoved'

    def interfaces_added(signal, proc_name = INTERFACES_ADDED)
      self.proc = proc_name
      LogActually.interface_object_manager.debug(proc) { signal.class }
      LogActually.interface_object_manager.debug(proc) { signal.object_suffixed }
      signal.filtered_interfaces.each do |interface, properties|
        LogActually.interface_object_manager.debug(proc) { "\t#{interface}" }
        parse_properties(properties)
      end
    end

    def interfaces_removed(signal, proc_name = INTERFACES_REMOVED)
      self.proc = proc_name
      LogActually.interface_object_manager.debug(proc) { signal.class }
      LogActually.interface_object_manager.debug(proc) { signal.object_suffixed }
      signal.filtered_interfaces.each do |interface|
        LogActually.interface_object_manager.debug(proc) { "\t#{interface}" }
      end
    end
  end
end
