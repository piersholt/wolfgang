# frozen_string_literal: true

# Comment
class CommandListener
  include Singleton
  # include NotificationDelegator

  attr_accessor :handler

  def logger
    LogActually.messaging
  end

  def pop_and_delegate(i)
    logger.debug('Command') { "#{i}. Wait" }
    command = Subscriber.recv
    logger.debug('Command') { "#{i}. #{command}" }
    handler.thy_will_be_done!(command)
  rescue IfYouWantSomethingDone
    logger.warn(self.class) { 'Chain did not handle!' }
  rescue StandardError => e
    logger.error(PROC) { e }
    e.backtrace.each { |l| logger.error(l) }
  end

  def listen
    Thread.new do
      Thread.current[:name] = 'CommandListener'
      Subscriber.mbp
      Subscriber.subscribe(:media)
      begin
        logger.warn('CommandListener') { 'Thread start!' }
        i = 1
        loop do
          pop_and_delegate(i)
          i += 1
        end
        logger.warn('CommandListener') { 'Thread end!' }
      rescue StandardError => e
        logger.error(self.class) { e }
        e.backtrace.each do |line|
          logger.error(self.class) { line }
        end
      end
    end
  end

  def self.listen(commands_queue)
    instance.listen(commands_queue)
  end

  def self.handler(handler)
    instance.handler = handler
  end
end
