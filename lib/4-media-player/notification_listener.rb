# frozen_string_literal: true

# Comment
module LazyLogger
  def d(message, proc = nil)
    if proc
      LOGGER.debug(proc) { message }
    else
      LOGGER.debug(message)
    end
  end
end

# Comment
class NotificationListener
  include Singleton
  include ChainDelegator
  include LazyLogger

  attr_accessor :handler

  def listen(mq)
    Thread.new(mq) do |mq|
      begin
        LOGGER.warn('Notification') { 'Thread start!' }
        i = 1
        loop do
          LOGGER.debug('Notification') { "#{i}. Wait" }
          notification = mq.pop
          LOGGER.debug('Notification') { "#{i}. #{notification}" }
          shirk(notification)
          i += 1
        end
        LOGGER.warn('Notification') { 'Thread end!' }
      rescue StandardError => e
        LOGGER.error(self.class) { e }
        e.backtrace.each do |line|
          LOGGER.error(self.class) { line }
        end
      end
    end
  end

  def self.listen(mq)
    instance.listen(mq)
  end

  def self.handler(handler)
    instance.handler = handler
  end
end
