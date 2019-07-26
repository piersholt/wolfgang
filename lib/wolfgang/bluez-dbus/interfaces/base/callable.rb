# frozen_string_literal: true

module Wolfgang
  # Callable
  module Callable
    def interface_called(listener, method, klass = InterfaceCalled)
      logger.debug(self.class) { '#interface_called' }
      callback = on_call_block(listener, method, klass)
      on_calls(callback)
    end

    def called(interface_name, method_name, properties = {})
      logger.debug(self.class) { '#called' }
      call_callback = fetch_callback(method_name)
      # logger.debug(self.class) { "callback: #{call_callback}" }
      call_callback.call(interface_name, method_name, properties)
    end

    private

    def fetch_callback(method)
      if method_callback?(method)
        method_callback(method)
      elsif interface_callback?
        interface_callback
      else
        default_callback
      end
    end

    # METHOD SPECIFIC CALLBACKS

    # add method specific callback
    def on_call(method, callback)
      method_callback_map[method] = callback
    end

    def method_callback?(method)
      method_callback_map.key?(method)
    end

    def method_callback(method)
      method_callback_map[method]
    end

    def method_callback_map
      @method_callback_map ||= {}
    end

    # UNIVERSAL CALLBACKS

    # add call back to all interface method calls
    def on_calls(callback)
      @interface_callback = callback
    end

    def interface_callback?
      @interface_callback ? true : false
    end

    def interface_callback
      @interface_callback
    end

    # DEFAULT

    def on_call_block(listener, method, klass, properties = {})
      proc do |called_interface, called_method|
        begin
          logger.debug('Interface') { "Thread: #{Thread.current}: #{Thread.current[:name]}" }
          logger.debug('Interface') { "Object: #{self}" }
          call_signal = klass.new(called_interface, called_method, properties)
          listener.public_send(method, call_signal)
        rescue StandardError => e
          logger.error('Interface') { e }
          e.backtrace.each { |line| logger.error(line) }
        end
      end
    end

    # def on_response_block(listener, method)
    #   proc do |response|
    #     begin
    #       logger.debug('Interface') { "Thread: #{Thread.current}: #{Thread.current[:name]}" }
    #       logger.debug('Interface') { "Object: #{self}" }
    #       logger.debug('Interface') { "Response: #{response}" }
    #       listener.public_send(method, response)
    #     rescue StandardError => e
    #       logger.error('Interface') { e }
    #       e.backtrace.each { |line| logger.error(line) }
    #     end
    #   end
    # end

    def on_call_default_block
      proc do |response|
        begin
          # logger.any(self.class) { "result inspect: #{response.inspect}" }
          logger.debug(self.class.name) { '#on_call_default_block' }
          logger.debug(self.class.name) { "result: #{response}" }
        rescue StandardError => e
          logger.error(self.class) { e }
          e.backtrace.each { |line| logger.error(line) }
        end
      end
    end

    alias default_callback on_call_default_block
    alias default_return_callback on_call_default_block
  end
end
