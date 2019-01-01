class MessagingQueue
  module ThreadSafe
    QUEUE_SIZE = 32

    # def self.queue
    #   instance.queue
    # end


    def queue_message(message)
      logger.debug(self.class) { "Queue Message" }
      logger.debug(self.class) { "Queued Message: #{message}" }
      queue.push(message)
      true
    rescue StandardError => e
      with_backtrace(logger, e)
      false
    end

    def queue
      @queue ||= create_queue
    end

    def worker
      @worker ||= create_worker
    end

    def fuck_off?
      @fuck_off ||= false
    end

    def fuck_off!
      @fuck_off = true
    end

    def worker_process(thread_queue)
      i = 1
      loop do
        message_hash = pop(i, thread_queue)
        forward_to_zeromq(message_hash[:topic], message_hash[:payload])
        i += 1
        # Kernel.sleep(3)
      end
    end

    def create_queue
      LogActually.messaging.debug(self.class) { 'Create Queue' }
      new_queue = SizedQueue.new(QUEUE_SIZE)
      create_worker(new_queue)
      new_queue
    rescue StandardError => e
      with_backtrace(logger, e)
    end

    def create_worker(existing_queue = nil)
      return false if fuck_off?
      LogActually.messaging.debug(self.class) { 'Create Worker' }
      q = existing_queue ? existing_queue : queue
      Thread.new(q) do |thread_queue|
        LogActually.messaging.debug(self.class) { "Worker: #{Thread.current}" }
        Thread.current[:name] = 'Publisher Worker'
        # Publisher.announce
        # Kernel.sleep(3)
        begin
          logger.debug(self.class) { 'Worker starting...' }
          worker_process(thread_queue)
          logger.warn(self.class) { 'Worker ended...!' }
        rescue StandardError => e
          logger.error(self.class) { e }
          e.backtrace.each do |line|
            logger.error(self.class) { line }
          end
        end
      end
      fuck_off!
    end

    def pop(i, thread_queue)
      logger.debug(self.class) { "Worker waiting (Next: Message ID: #{i})" }
      popped_messsage = thread_queue.pop
      popped_messsage.id = i
      popped_messsage.session = Time.now.strftime("%j_%H_%M")
      message_hash = { topic: topic(popped_messsage),
                       payload: payload(popped_messsage) }

      logger.debug(self.class) { "Message ID: #{i} => #{message_hash}" }
      message_hash
    rescue IfYouWantSomethingDone
      logger.warn(self.class) { 'Chain did not handle!' }
    end

    def forward_to_zeromq(topic, payload)
      LogActually.messaging.debug(self.class) { "Worker: #{Thread.current}" }
      topic = sanitize(topic)
      payload = sanitize(payload)
      # LogActually.messaging.debug(counter)

      result_topic = sendm(topic)
      result_payload = send(payload)
      LogActually.messaging.debug(topic)
      LogActually.messaging.debug(payload)
      raise StandardError, 'Failed send?' unless result_topic && result_payload
      # self.counter = counter + 1
    end
  end
end
