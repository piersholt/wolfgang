# frozen_string_literal: true

module PropertiesListener
  def properties_changed(signal, proc_name = 'PropertiesChanged')
    self.proc = proc_name

    LogActually.properties.debug(proc) { "#{signal.path_suffixed}" }
    LogActually.properties.debug(proc) { "\t#{signal.target}" }

    parse_properties(signal.changed)

    signal.removed.each do |property|
      LogActually.properties.debug(proc) { "-#{property}: nil" }
    end
  end
end
