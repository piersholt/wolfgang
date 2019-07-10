# frozen_string_literal: true

module Wolfgang
  module Properties
    # Properties::Signals
    module Signals
      include SignalConstants

      PROG = 'Properties::Signals'

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
            LOGGER.debug(PROG) { "Thread: #{Thread.current}: #{Thread.current[:name]}" }
            LOGGER.debug(PROG) { "Object: #{self}" }
            signal = klass.new(path, i, c, r)
            LOGGER.debug(PROG) { signal.interface }
            LOGGER.debug(PROG) { signal.member }
            LOGGER.debug(PROG) { "Interface: #{signal.target}" }
            LOGGER.debug(PROG) { "Changed: #{signal.changed}" }
            LOGGER.debug(PROG) { "Removed: #{signal.removed}" }
            listener.public_send(method, signal)
          rescue StandardError => e
            LOGGER.error(PROG) { e }
            e.backtrace.each { |line| LOGGER.error(PROG) { line } }
          end
        end
      end
    end
  end
end
