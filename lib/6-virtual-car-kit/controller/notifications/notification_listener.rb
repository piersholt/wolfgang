# frozen_string_literal: true

# Comment
class NotificationListener
  include Singleton
  include NotificationDelegator
  # include LazyLogger

  attr_accessor :handler

  def pop_and_delegate(i, nq)
    LOGGER.debug('Notification') { "#{i}. Wait" }
    notification = nq.pop
    LOGGER.debug('Notification') { "#{i}. #{notification}" }
    delegate(notification)
  rescue IfYouWantSomethingDone
    LOGGER.warn(self.class) { 'Chain did not handle!' }
  end

  def listen(notifications_queue)
    Thread.new(notifications_queue) do |nq|
      Thread.current[:name] = 'NotificationListener'
      Publisher.ready
      begin
        LOGGER.warn('Notification') { 'Thread start!' }
        i = 1
        loop do
          pop_and_delegate(i, nq)
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

  def self.listen(notifications_queue)
    instance.listen(notifications_queue)
  end

  def self.handler(handler)
    instance.handler = handler
  end
end
