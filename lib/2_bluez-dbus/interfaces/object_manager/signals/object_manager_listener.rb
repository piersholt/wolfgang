# frozen_string_literal: true

module ObjectManagerListener
  def interfaces_added(signal)
    self.proc = 'InterfaceAdded'
    # self.proc = signal.object
    LOGGER.info(proc) { "#{signal.object_suffixed}" }
    signal.filtered_interfaces.each do |interface, properties|
      LOGGER.info(proc) { "\t#{interface}" }
      parse_properties(properties)
    end
  end

  def interfaces_removed(signal)
    self.proc = 'InterfaceRemoved'
    LOGGER.info(proc) { "#{signal.object_suffixed}" }
    signal.filtered_interfaces.each do |interface|
      LOGGER.info(proc) { "\t#{interface}" }
    end
  end
end
