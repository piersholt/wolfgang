# frozen_string_literal: true

# Comment
class CommandListener
  include Singleton
  include NotificationDelegator
  include ManageableThreads

  attr_reader :listener_thread

  def logger
    LogActually.messaging
  end

  def deserialize(serialized_object)
    command = Messaging::Serialized.new(serialized_object).parse
    logger.info(self.class) { "Deserialized: #{command}" }
    logger.info(self.class) { "name: #{command.name} (#{command.name.class})" }
    command
  end

  # SUBSCRIBER ----------------------------------------------------------------

  def pop_and_delegate(i)
    logger.debug(self.class) { "SUB #{i}. Wait" }
    serialized_object = Subscriber.recv
    command = deserialize(serialized_object)
    delegate(command)
  rescue IfYouWantSomethingDone
    logger.debug(self.class) { "Chain did not handle! (#{command})" }
  rescue StandardError => e
    logger.error(self.class) { e }
    e.backtrace.each { |line| logger.error(self.class) { line } }
  end

  def listen_loop
    i = 1
    loop do
      pop_and_delegate(i)
      i += 1
    end
  rescue StandardError => e
    logger.error(self.class) { e }
    e.backtrace.each do |line|
      logger.error(self.class) { line }
    end
  end

  def listen
    logger.debug(self.class) { "#listen" }
    @listener_thread =
      Thread.new do
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
          logger.error(self.class) { e }
          e.backtrace.each do |line|
            logger.error(self.class) { line }
          end
        end
        logger.warn('CommandListener') { 'Listening thread is ending?' }
      end
    add_thread(@listener_thread)
  end

  # REPLY ---------------------------------------------------------------------

  def reply_iteration(i)
    logger.debug(self.class) { "REP #{i}. Wait" }
    serialized_object = Server.recv
    command = deserialize(serialized_object)
    # logger.debug(self.class) { "recv => #{command}" }
    # CommandListener.instance.delegate(command)
    delegate(command)
    # result = send('pong')
    # logger.debug(self.class) { "send('pong') => #{result}" }
  rescue IfYouWantSomethingDone
    logger.warn(self.class) { "Chain did not handle! (#{command})" }
  rescue StandardError => e
    logger.error(self.class) { e }
    e.backtrace.each { |line| logger.error(self.class) { line } }
  end

  def reply_loop
    i = 0
    loop do
      reply_iteration(i)
      i += 1
    end
  end

  def start
    logger.debug(self.class) { "#start" }
    @thread = Thread.new do
      begin
        Thread.current[:name] = 'CommandListener (REP)'
        Kernel.sleep(5)

        connection_options = {
          port: ENV['server_port'],
          host: ENV['server_host']
        }
        logger.debug('CommandListener (REP)') { "Server connection options: #{connection_options}" }
        Server.params(connection_options)

        logger.debug('CommandListener (REP)') { 'Thread listen start!' }
        reply_loop
        logger.debug('CommandListener (REP)') { 'Thread listen end!' }
      rescue StandardError => e
        logger.fatal(self.class) { e }
        e.backtrace { |line| logger.fatal(self.class) { line } }
      end
      logger.warn(self.class) { 'Test thread ending?' }
    end
  end

  # METHODS -------------------------------------------------------------------

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
