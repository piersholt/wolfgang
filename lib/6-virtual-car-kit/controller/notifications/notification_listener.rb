# frozen_string_literal: true

# Comment
class NotificationListener
  include Singleton
  include NotificationDelegator
  # include LazyLogger

  attr_accessor :handler

  def logger
    LogActually.messaging
  end

  def pop_and_delegate(i, nq)
    logger.debug('Notification') { "#{i}. Wait" }
    notification = nq.pop
    logger.debug('Notification') { "#{i}. #{notification}" }
    delegate(notification)
  rescue IfYouWantSomethingDone
    logger.warn(self.class) { 'Chain did not handle!' }
  end

  def listen(notifications_queue)
    Thread.new(notifications_queue) do |nq|
      Thread.current[:name] = 'NotificationListener'
      # Publisher.ready
      begin
        logger.warn('NotificationListener') { 'Thread start!' }
        i = 1
        loop do
          pop_and_delegate(i, nq)
          i += 1
        end
        logger.warn('NotificationListener') { 'Thread end!' }
      rescue StandardError => e
        logger.error(self.class) { e }
        e.backtrace.each do |line|
          logger.error(self.class) { line }
        end
      end
    end
  end

  def self.listen(notifications_queue)
    instance.listen(notifications_queue)
  end

  def self.handler(handler)
    instance.handler = handler
  end
end
