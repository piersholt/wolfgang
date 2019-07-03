# frozen_string_literal: true

require_relative 'listener/server'
require_relative 'listener/subscriber'

module Wolfgang
  # CommandListener
  class CommandListener
    include Singleton
    include NotificationDelegator
    include ManageableThreads

    PROG = 'CommandListener'
    DELAY = 5
    ITERATION_SEED = 1

    include CommandServer
    include CommandSubscriber

    attr_reader :listener_thread

    def logger
      LogActually.messaging
    end

    def deserialize(serialized_object)
      command = Messaging::Serialized.new(serialized_object).parse
      logger.info(PROG) { "Deserialized: #{command}" }
      logger.info(PROG) { "name: #{command.name} (#{command.name.class})" }
      command
    end

    def self.handler(handler)
      instance.handler = handler
    end
  end
end
