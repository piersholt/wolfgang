# frozen_string_literal: true
class BluezControllerListener < BaseSignalListener
  include Singleton
  PROC = 'Controller'

  def new_controller(controller)
    logger.debug(PROC) { 'New Controller!' }
    # controller.properties.properties_changed(self, :properties_changed)
    controller.properties.listen(:properties_changed, self)
  end


  def logger
    LogActually.controller
  end
end
