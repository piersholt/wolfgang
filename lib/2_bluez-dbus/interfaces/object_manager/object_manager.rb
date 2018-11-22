# frozen_string_literal: true

# An API can optionally make use of this interface for one or more sub-trees
# of objects. The root of each sub-tree implements this interface so other
# applications can get all objects, interfaces and properties in a single
# method call. It is appropriate to use this interface if users of the tree
# of objects are expected to be interested in all interfaces of all objects in
# the tree; a more granular API should be used if users of the objects are
# expected to be interested in a small subset of the objects, a small subset of
# their interfaces, or both.
module ObjectManager
  include InterfaceConstants
  include ObjectManager::Signals

  # @deprecated
  alias_method :get_managed_objects, :managed_objects

  def object_manager
    self.default_iface = OBJECT_MANAGER
    @selected_interface = OBJECT_MANAGER
    self
  end

  def managed_objects
    object_manager_interface.GetManagedObjects
  end

  def object_manager_interface
    interface(OBJECT_MANAGER)
  end

  # begin
  #   signal = InterfacesAdded.new(object, changes)
  #
  #   LOGGER.debug('InterfacesAdded') { "Thread: #{Thread.current}: #{Thread.current[:name]}" }
  #   LOGGER.debug('InterfacesAdded') { "Object: #{self}" }
  #   LOGGER.debug('InterfacesAdded') { signal.interface }
  #   LOGGER.debug('InterfacesAdded') { signal.member }
  #   LOGGER.debug('InterfacesAdded') { "Object: #{signal.object_path}" }
  #   # LOGGER.debug('InterfacesAdded') { "Interfaces Added: #{signal.changes}" }
  #   LOGGER.debug('InterfacesAdded') { "Interfaces Added (filtered): #{signal.filtered_interfaces}" }
  #
  #   listener.interfaces_added(signal)
  # rescue StandardError => e
  #   LOGGER.error('ObjectManager') { e }
  #   e.backtrace.each { |line| LOGGER.error(line) }
  # end

  # def interfaces_added(listener)
  #   object_manager.on_signal('InterfacesAdded') do |object, changes|
  #   begin
  #     signal = InterfacesAdded.new(object, changes)
  #
  #     LOGGER.debug('InterfacesAdded') { "Thread: #{Thread.current}: #{Thread.current[:name]}" }
  #     LOGGER.debug('InterfacesAdded') { "Object: #{self}" }
  #     LOGGER.debug('InterfacesAdded') { signal.interface }
  #     LOGGER.debug('InterfacesAdded') { signal.member }
  #     LOGGER.debug('InterfacesAdded') { "Object: #{signal.object_path}" }
  #     # LOGGER.debug('InterfacesAdded') { "Interfaces Added: #{signal.changes}" }
  #     LOGGER.debug('InterfacesAdded') { "Interfaces Added (filtered): #{signal.filtered_interfaces}" }
  #
  #     listener.interfaces_added(signal)
  #   rescue StandardError => e
  #     LOGGER.error('ObjectManager') { e }
  #     e.backtrace.each { |line| LOGGER.error(line) }
  #   end
  # end
end
