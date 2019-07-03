# frozen_string_literal: true
class BluezControllerListener < BaseSignalListener
  include Singleton
  PROC = 'Controller'

  def new_controller(controller)
    logger.debug(PROC) { 'New Controller!' }
    properties_changed_signal_registration(controller)
  end

  def properties_changed_signal_registration(controller)
    LogActually.service.debug(name) { 'properties_changed signal registration.' }
    controller.properties.listen(:properties_changed, self)
  end

  def name
    'ControllerListener'
  end

  def logger
    LogActually.controller
  end
end