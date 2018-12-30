# frozen_string_literal: true

class BluezPlayerListener < BaseSignalListener
  include Singleton
  include SignalDelegator

  # @override PropertiesListener
  def properties_changed(signal)
    super(signal, 'Player#PropertiesChanged')
    delegate(:properties_changed, signal)
  rescue IfYouWantSomethingDone
    logger.warn(proc) { 'Chain did not handle!' }
  end

  def logger
    LogActually.player
  end
end
