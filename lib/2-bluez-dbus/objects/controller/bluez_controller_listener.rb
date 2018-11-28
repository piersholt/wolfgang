# frozen_string_literal: true
class BluezControllerListener < BaseSignalListener
  include Singleton
  PROC = 'Controller'

  def new_controller(controller)
    LOGGER.debug(PROC) { 'New Controller!' }
    controller.properties.properties_changed(self, :properties_changed)
  end
end
