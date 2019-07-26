# frozen_string_literal: true

module Wolfgang
  # BluezControllerListener
  class BluezControllerListener < BaseSignalListener
    include Singleton
    PROC = 'Controller'
    PROG = 'ControllerListener'

    def new_controller(controller)
      logger.debug(PROC) { 'New Controller!' }
      properties_changed_signal_registration(controller)
    end

    def properties_changed_signal_registration(controller)
      LogActually.service_bluez.debug(prog) { 'properties_changed signal registration.' }
      controller.properties.listen(:properties_changed, self)
    end

    def prog
      PROG
    end

    def logger
      LogActually.object_controller
    end
  end
end
