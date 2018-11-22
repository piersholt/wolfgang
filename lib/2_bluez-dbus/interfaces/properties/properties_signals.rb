# frozen_string_literal: true

require 'observer'
module Properties
  module Signals
    # include InterfaceConstants
    include SignalConstants

    def properties_changed(listener, method, klass = PropertiesChanged)
      callback =
        proc do |i, c, r|
          begin
            LOGGER.debug('Properties') { "Thread: #{Thread.current}: #{Thread.current[:name]}" }
            LOGGER.debug('Properties') { "Object: #{self}" }

            signal = klass.new(path, i, c, r)

            LOGGER.debug('Properties') { signal.interface }
            LOGGER.debug('Properties') { signal.member }
            LOGGER.debug('Properties') { "Interface: #{signal.target}" }
            LOGGER.debug('Properties') { "Changed: #{signal.changed}" }
            LOGGER.debug('Properties') { "Removed: #{signal.removed}" }

            listener.public_send(method, signal)
          rescue StandardError => e
            LOGGER.error('Properties') { e }
            e.backtrace.each { |line| LOGGER.error(line) }
          end
        end

      properties.on_signal('PropertiesChanged', &callback)
    end
  end
end
