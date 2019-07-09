# frozen_string_literal: true

module Wolfgang
  # NotificationListener
  class NotificationListener
    include Singleton
    include Yabber::NotificationDelegator
    include ManageableThreads

    PROG = 'NotificationListener'
    ITERATION_SEED = 1

    attr_accessor :handler

    def logger
      LOGGER
    end

    def pop_and_delegate(i, queue)
      logger.debug(PROG) { "#{i}. Wait" }
      notification = queue.pop
      logger.debug(PROG) { "#{i}. #{notification}" }
      delegate(notification)
    rescue Yabber::IfYouWantSomethingDone
      logger.warn(PROG) { 'Chain did not handle!' }
    end

    def notification_loop(queue)
      i = ITERATION_SEED
      loop do
        pop_and_delegate(i, queue)
        i += 1
      end
    end

    def listen(notifications_queue)
      logger.debug(PROG) { '#listen' }
      @bluez_notification_listener = Thread.new(notifications_queue) do |queue|
        begin
          Thread.current[:name] = PROG

          logger.warn(PROG) { 'Thread start!' }
          notification_loop(queue)
          logger.warn(PROG) { 'Thread end!' }
        rescue StandardError => e
          logger.error(PROG) { e }
          e.backtrace.each { |line| logger.error(PROG) { line } }
        end
        add_thread(@bluez_notification_listener)
      end
      logger.warn(PROG) { 'Thread ending!' }
    end

    def self.listen(notifications_queue)
      instance.listen(notifications_queue)
    end

    def self.handler(handler)
      instance.handler = handler
    end
  end
end
