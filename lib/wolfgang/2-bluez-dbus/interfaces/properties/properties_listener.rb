# frozen_string_literal: true

module Wolfgang
  # PropertiesListener
  module PropertiesListener
    def properties_changed(signal, proc_name = 'PropertiesChanged')
      self.proc = proc_name

      logger?.debug(name) { signal.path_suffixed }
      logger?.debug(name) { "\t#{signal.target}" }

      parse_changed(signal.changed)
      parse_removed(signal.removed)
    end
  end
end
