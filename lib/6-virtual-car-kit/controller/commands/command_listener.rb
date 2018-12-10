# frozen_string_literal: true

# Comment
class CommandListener
  include Singleton
  # include NotificationDelegator

  attr_accessor :handler

  def pop_and_delegate(i)
    LOGGER.debug('Command') { "#{i}. Wait" }
    command = Subscriber.recv
    LOGGER.debug('Command') { "#{i}. #{command}" }
    handler.thy_will_be_done!(command)
  rescue IfYouWantSomethingDone
    LOGGER.warn(self.class) { 'Chain did not handle!' }
  rescue StandardError => e
    LOGGER.error(PROC) { e }
    e.backtrace.each { |l| LOGGER.error(l) }
  end

  def listen
    Thread.new do
      Thread.current[:name] = 'CommandListener'
      Subscriber.mbp
      Subscriber.subscribe(:media)
      begin
        LOGGER.warn('Command') { 'Thread start!' }
        i = 1
        loop do
          pop_and_delegate(i)
          i += 1
        end
        LOGGER.warn('Command') { 'Thread end!' }
      rescue StandardError => e
        LOGGER.error(self.class) { e }
        e.backtrace.each do |line|
          LOGGER.error(self.class) { line }
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
