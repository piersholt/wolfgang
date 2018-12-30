# frozen_string_literal: true

# Comment
module Callable
  def interface_called(listener, method, klass = InterfaceCalled)
    callback = on_call_block(listener, method, klass)
    on_calls(callback)
  end

  def called(interface_name, method_name)
    LOGGER.debug(self.class) { '#on_call_default_block' }
    call_callback = fetch_callback(method_name)
    LOGGER.debug(self.class) { "callback: #{call_callback}" }
    call_callback.call(interface_name, method_name)
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

  def default_callback
    on_call_default_block
  end

  def default_return_callback
    on_call_default_block
  end

  def on_call_block(listener, method, klass)
    proc do |called_interface, called_method|
      begin
        LOGGER.debug('Interface') { "Thread: #{Thread.current}: #{Thread.current[:name]}" }
        LOGGER.debug('Interface') { "Object: #{self}" }
        call = klass.new(called_interface, called_method)
        listener.public_send(method, call)
      rescue StandardError => e
        LOGGER.error('Interface') { e }
        e.backtrace.each { |line| LOGGER.error(line) }
      end
    end
  end

  # def on_response_block(listener, method)
  #   proc do |response|
  #     begin
  #       LOGGER.debug('Interface') { "Thread: #{Thread.current}: #{Thread.current[:name]}" }
  #       LOGGER.debug('Interface') { "Object: #{self}" }
  #       LOGGER.debug('Interface') { "Response: #{response}" }
  #       listener.public_send(method, response)
  #     rescue StandardError => e
  #       LOGGER.error('Interface') { e }
  #       e.backtrace.each { |line| LOGGER.error(line) }
  #     end
  #   end
  # end

  def on_call_default_block
    proc do |response|
      begin
        # LOGGER.any(self.class) { "result inspect: #{response.inspect}" }
        LOGGER.unknown(self.class) { '#on_call_default_block' }
        LOGGER.unknown(self.class) { "result: #{response}" }
      rescue StandardError => e
        LOGGER.error(self.class) { e }
        e.backtrace.each { |line| LOGGER.error(line) }
      end
    end
  end
end
