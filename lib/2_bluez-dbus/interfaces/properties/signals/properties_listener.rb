# frozen_string_literal: true

module PropertiesListener
  def properties_changed(signal, proc_name = 'PropertiesChanged')
    self.proc = proc_name

    LOGGER.info(proc) { "#{signal.path_suffixed}" }
    LOGGER.info(proc) { "\t#{signal.target}" }

    parse_properties(signal.changed)

    signal.removed.each do |property|
      LOGGER.info(proc) { "-#{property}: nil" }
    end
  end
end
