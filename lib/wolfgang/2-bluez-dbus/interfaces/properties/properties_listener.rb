# frozen_string_literal: true

module Wolfgang
  # PropertiesListener
  module PropertiesListener
    PROC_NAME_DEFAULT = 'PropertiesChanged'
    def properties_changed(signal, proc_name = PROC_NAME_DEFAULT)
      self.proc = proc_name

      logger?.debug(prog) { signal.path_suffixed }
      logger?.debug(prog) { "\t#{signal.target}" }

      parse_changed(signal.changed)
      parse_removed(signal.removed)
    end
  end
end
