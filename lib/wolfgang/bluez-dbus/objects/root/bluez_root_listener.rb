# frozen_string_literal: true

module Wolfgang
  # BluezRootListener
  class BluezRootListener < BaseSignalListener
    include Singleton
    include SignalDelegator

    def logger
      LogActually.interface_object_manager
    end

    # @override ObjectManagerListener
    def interfaces_added(signal)
      super(signal, 'Root#InterfacesAdded')
      delegate(:interfaces_added, signal)
    rescue Yabber::IfYouWantSomethingDone
      LOGGER.warn(proc) { 'Chain did not handle!' }
    end

    # @override ObjectManagerListener
    def interfaces_removed(signal)
      super(signal, 'Root#InterfacesRemoved')
    end

    def new_root(root)
      LOGGER.debug(PROC) { 'New Root!' }
      root.object_manager.listen(:interfaces_added, self)
      root.object_manager.listen(:interfaces_removed, self)
    end
  end
end
