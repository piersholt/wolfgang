# frozen_string_literal: true

class BluezPlayerListener < BaseSignalListener
  include Singleton
  include ChainDelegator

  # @override PropertiesListener
  def properties_changed(signal)
    super(signal, 'Player#PropertiesChanged')
    shirk(signal)
  rescue IfYouWantSomethingDone
    LOGGER.warn(proc) { 'Chain did not handle!' }
  end
end
