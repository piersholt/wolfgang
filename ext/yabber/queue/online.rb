class MessagingQueue
  module Announce
    def online(who_am_i)
      # logger.debug('Announce') { "Spawn Thread" }
      Thread.new(who_am_i) do |who_am_i|
        # logger.debug('Announce') { "Thead new" }
        begin
          # logger.debug('Announce') { "Start" }
          2.times do |i|
            online_publish(who_am_i)
            Kernel.sleep(0.5)
            # logger.debug('Announce') { "announce #{i}" }
          end
          # logger.debug('Announce') { 'Finish' }
        rescue StandardError => e
          with_backtrace(logger, e)
        end
        # logger.debug('Announce') { "Thead end" }
      end
      # logger.debug('Announce') { "Spawned Thread" }
    end

    def online_publish(who_am_i)
      n = Messaging::Notification.new(topic: who_am_i, name: :online)
      LogActually.messaging.debug(self.class) { "Publisher Ready Send." }
      # Publisher.send(n.topic, n)
      Publisher.send!(n)
    end
  end
end
