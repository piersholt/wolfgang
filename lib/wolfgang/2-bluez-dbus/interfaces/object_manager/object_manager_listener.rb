# frozen_string_literal: true

module Wolfgang
  module ObjectManagerListener
    def interfaces_added(signal, proc_name = 'InterfacesAdded')
      self.proc = proc_name
      LogActually.object_manager.debug(proc) { "#{signal.class}" }
      LogActually.object_manager.debug(proc) { "#{signal.object_suffixed}" }
      signal.filtered_interfaces.each do |interface, properties|
        LogActually.object_manager.debug(proc) { "\t#{interface}" }
        parse_properties(properties)
      end
    end

    def interfaces_removed(signal, proc_name = 'InterfacesAdded')
      self.proc = proc_name
      LogActually.object_manager.debug(proc) { "#{signal.class}" }
      LogActually.object_manager.debug(proc) { "#{signal.object_suffixed}" }
      signal.filtered_interfaces.each do |interface|
        LogActually.object_manager.debug(proc) { "\t#{interface}" }
      end
    end
  end
end
