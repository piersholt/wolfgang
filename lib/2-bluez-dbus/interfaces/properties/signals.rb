# frozen_string_literal: true

require 'observer'
module Properties
  module Signals
    include SignalConstants

    def listen(signal, listener, options = {})
      raise(NameError, 'signal does not exists!') unless
        PROPERTIES_SIGNALS.key?(signal)
      send(signal, listener, **options)
    end

    private

    def properties_changed(listener,
                           method: :properties_changed,
                           klass: PropertiesChanged)
      signal = PROPERTIES_SIGNALS[:properties_changed]
      callback = on_signal_callback(klass, listener, method)
      properties.on_signal(signal, &callback)
    end

    # def properties_changed(listener, method, klass: PropertiesChanged, method: :properties_changed)
    #   signal = PROPERTIES_SIGNALS[:properties_changed]
    #   callback = on_signal_callback(listener, method, klass)
    #   properties.on_signal(signal, &callback)
    # end

    def on_signal_callback(klass, listener, method)
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
    end
  end
end
