# frozen_string_literal: true

# Base listener for all objects
class BluezBaseListener
  DEFAULT_HANDLERS = {}.freeze

  def handlers
    @handlers ||= empty_handlers
  end

  def register_handler(handler)
    handlers[handler.target] = handler
  end

  def empty_handlers
    DEFAULT_HANDLERS.dup
  end

  def no_handler
    LOGGER.warn(self.class) { "#{interface} not handled!" }
  end
end
