# frozen_string_literal: true

# Comment
class NotificationListener
  include Singleton
  include NotificationDelegator
  include ManageableThreads

  attr_accessor :handler

  def logger
    LOGGER
  end

  def pop_and_delegate(i, nq)
    logger.debug(self.class) { "#{i}. Wait" }
    notification = nq.pop
    logger.debug(self.class) { "#{i}. #{notification}" }
    delegate(notification)
  rescue IfYouWantSomethingDone
    logger.warn(self.class) { 'Chain did not handle!' }
  end

  def listen(notifications_queue)
    @bluez_notification_listener = Thread.new(notifications_queue) do |nq|
      Thread.current[:name] = 'NotificationListener'
      begin
        logger.warn(self.class) { 'Thread start!' }
        i = 1
        loop do
          pop_and_delegate(i, nq)
          i += 1
        end
        logger.warn(self.class) { 'Thread end!' }
      rescue StandardError => e
        logger.error(self.class) { e }
        e.backtrace.each do |line|
          logger.error(self.class) { line }
        end
      end
      add_thread(@bluez_notification_listener)
    end
  end

  def self.listen(notifications_queue)
    instance.listen(notifications_queue)
  end

  def self.handler(handler)
    instance.handler = handler
  end
end
