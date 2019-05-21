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

  def pop_and_delegate(i)
    logger.debug(self.class) { "#{i}. Wait" }
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
    @listener_thread =
      Thread.new do
        begin
          Thread.current[:name] = 'CommandListener'
          Kernel.sleep(5)
          Subscriber.mbp

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
