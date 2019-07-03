# frozen_string_literal: true

module Wolfgang
  # CommandListener
  class CommandListener
    include Singleton
    include NotificationDelegator
    include ManageableThreads

    PROG = 'CommandListener'
    THREAD = 'CommandListener [REP]'
    DELAY = 5

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

    # SUBSCRIBER --------------------------------------------------------------

    def pop_and_delegate(i)
      logger.debug(PROG) { "SUB #{i}. Wait" }
      serialized_object = Subscriber.recv
      command = deserialize(serialized_object)
      delegate(command)
    rescue IfYouWantSomethingDone
      logger.debug(PROG) { "Chain did not handle! (#{command})" }
    rescue StandardError => e
      logger.error(PROG) { e }
      e.backtrace.each { |line| logger.error(PROG) { line } }
    end

    def listen_loop
      i = 1
      loop do
        pop_and_delegate(i)
        i += 1
      end
    rescue StandardError => e
      logger.error(PROG) { e }
      e.backtrace.each do |line|
        logger.error(PROG) { line }
      end
    end

    def listen
      logger.debug(PROG) { '#listen' }
      @listener_thread = Thread.new do
        begin
          Thread.current[:name] = 'CommandListener (SUB)'
          Kernel.sleep(5)
          connection_options = {
            port: ENV['subscriber_port'],
            host: ENV['subscriber_host']
          }
          logger.debug('CommandListener') { "Subscriber connection options: #{connection_options}" }
          Subscriber.params(connection_options)

          logger.debug('CommandListener') { 'Thread listen start!' }
          listen_loop
          logger.debug('CommandListener') { 'Thread listen end!' }
        rescue StandardError => e
          logger.error(PROG) { e }
          e.backtrace.each do |line|
            logger.error(PROG) { line }
          end
        end
        logger.warn('CommandListener') { 'Listening thread is ending?' }
      end
      add_thread(@listener_thread)
    end

    # REPLY -------------------------------------------------------------------

    def reply_iteration(i)
      logger.debug(PROG) { "REP #{i}. Wait" }
      serialized_object = Server.recv
      command = deserialize(serialized_object)
      delegate(command)
    rescue IfYouWantSomethingDone
      logger.warn(PROG) { "Chain did not handle! (#{command})" }
    rescue StandardError => e
      logger.error(PROG) { e }
      e.backtrace.each { |line| logger.error(PROG) { line } }
    end

    def reply_loop
      i = 0
      loop do
        reply_iteration(i)
        i += 1
      end
    end

    def start
      logger.debug(PROG) { '#start' }
      @thread = Thread.new do
        begin
          Thread.current[:name] = THREAD
          logger.debug(THREAD) { "Delay: #{DELAY} seconds." }
          Kernel.sleep(DELAY)

          connection_options = {
            port: ENV['server_port'],
            host: ENV['server_host']
          }
          logger.debug(THREAD) do
            "Server connection options: #{connection_options}"
          end
          Server.params(connection_options)

          logger.debug(THREAD) { 'Thread listen start!' }
          reply_loop
          logger.debug(THREAD) { 'Thread listen end!' }
        rescue StandardError => e
          logger.fatal(PROG) { e }
          e.backtrace { |line| logger.fatal(PROG) { line } }
        end
        logger.warn(PROG) { 'Test thread ending?' }
      end
    end

    # METHODS -----------------------------------------------------------------

    def ignore
      @listener_thread.stop.join
    end

    def self.ignore
      instance.ignore
    end

    def self.listen
      instance.listen
    end

    def self.handler(handler)
      instance.handler = handler
    end
  end
end
