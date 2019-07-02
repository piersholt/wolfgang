# frozen_string_literal: true

# An API can optionally make use of this interface for one or more sub-trees
# of objects. The root of each sub-tree implements this interface so other
# applications can get all objects, interfaces and properties in a single
# method call. It is appropriate to use this interface if users of the tree
# of objects are expected to be interested in all interfaces of all objects in
# the tree; a more granular API should be used if users of the objects are
# expected to be interested in a small subset of the objects, a small subset of
# their interfaces, or both.
module ObjectManager
  module Signals
    NEW_LINE = "\n"
    include SignalConstants

    def listen(signal, listener, options = {})
      raise(NameError, 'signal does not exists!') unless
        OBJECT_MANAGER_SIGNALS.key?(signal)
      send(signal, listener, **options)
    end

    private

    def interfaces_added(listener,
                         method: :interfaces_added,
                         klass: InterfacesAdded)
      signal = OBJECT_MANAGER_SIGNALS[:interfaces_added]
      callback = on_signal_callback(klass, listener, method)
      object_manager.on_signal(signal, &callback)
    end

    def interfaces_removed(listener,
                           klass: InterfacesRemoved,
                           method: :interfaces_removed)
      signal = OBJECT_MANAGER_SIGNALS[:interfaces_removed]
      callback = on_signal_callback(klass, listener, method)
      object_manager.on_signal(signal, &callback)
    end

    def on_signal_callback(klass, listener, method)
      proc do |object, changes|
        begin
          log_signal(object, changes)
          signal = klass.new(object, changes)
          log_callback(klass, signal)
          listener.public_send(method, signal)
        rescue StandardError => e
          LOGGER.error('ObjectManager') { e }
          e.backtrace.each { |line| LOGGER.error(line) }
        end
      end
    end

    def log_signal(object, changes)
      LOGGER.debug(self.class) { object }
      LOGGER.debug(self.class) { changes }
    end

    def log_callback(klass, signal)
      LOGGER.debug(klass) do
        thread = "Thread: #{Thread.current}: #{Thread.current[:name]}"
        object = "Object: #{self}"
        thread + new_line + object
      end
      LOGGER.debug(klass) do
        "#{signal.interface}##{signal.member}"
      end
      LOGGER.debug(klass) { "Object: #{signal.object_path}" }
      LOGGER.debug(klass) { "Changed*: #{signal.filtered_interfaces}" }
    end

    def new_line
      NEW_LINE.dup
    end
  end
end
