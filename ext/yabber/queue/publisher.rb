# frozen_string_literal: true

# Comment
class Publisher < MessagingQueue
  extend Forwardable

  def_delegators :socket, :send, :sendm

  DEFAULTS = {
    role: :PUB,
    protocol: 'tcp',
    address: '*',
    port: '5556'
  }.freeze

  def topic(message)
    message.topic
  end

  def payload(message)
    message.to_yaml
  end

  def queue_message(message)
    logger.debug(self.class) { "Queue Message" }
    logger.debug(self.class) { "Queued Message: #{message}" }
    queue.push(message)
    true
  rescue StandardError => e
    with_backtrace(logger, e)
    false
  end

  QUEUE_SIZE = 32

  def self.queue
    instance.queue
  end

  def queue
    @queue ||= create_queue
  end

  def create_queue
    LogActually.messaging.info(self.class) { 'Create Queue' }
    new_queue = SizedQueue.new(QUEUE_SIZE)
    create_worker(new_queue)
    new_queue
  rescue StandardError => e
    with_backtrace(logger, e)
  end

  def worker
    @worker ||= create_worker
  end

  def pop(i, thread_queue)
    logger.debug(self.class) { "Worker waiting (Next: Message ID: #{i})" }
    popped_messsage = thread_queue.pop
    popped_messsage.id = i
    popped_messsage.session = Time.now.strftime("%j_%H_%m")
    message_hash = { topic: topic(popped_messsage),
                     payload: payload(popped_messsage) }

    logger.debug(self.class) { "Message ID: #{i} => #{message_hash}" }
    message_hash
  rescue IfYouWantSomethingDone
    logger.warn(self.class) { 'Chain did not handle!' }
  end

  def fuck_off?
    @fuck_off ||= false
  end

  def fuck_off!
    @fuck_off = true
  end

  def create_worker(existing_queue = nil)
    return false if fuck_off?
    LogActually.messaging.info(self.class) { 'Create Worker' }
    q = existing_queue ? existing_queue : queue
    Thread.new(q) do |thread_queue|
      LogActually.messaging.debug(self.class) { "Worker: #{Thread.current}" }
      Thread.current[:name] = 'Publisher Worker'
      # Publisher.announce
      Kernel.sleep(3)
      begin
        logger.debug(self.class) { 'Worker starting...' }
        i = 1
        loop do
          message_hash = pop(i, thread_queue)
          forward_to_zeromq(message_hash[:topic], message_hash[:payload])
          i += 1
          Kernel.sleep(3)
        end
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

  def send!(message)
    queue_message(message)
  end

  def self.send!(message)
    instance.send!(message)
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

  def self.send(topic, payload)
    topic = instance.sanitize(topic)
    payload = instance.sanitize(payload)
    # LogActually.messaging.debug(counter)

    result_topic = instance.sendm(topic)
    result_payload = instance.send(payload)
    LogActually.messaging.debug(topic)
    LogActually.messaging.debug(payload)
    raise StandardError, 'Failed send?' unless result_topic && result_payload
    # self.counter = counter + 1
  end

  def online
    logger.debug('Announce') { "Spawn Thread" }
    Thread.new do
      logger.debug('Announce') { "Thead new" }
      begin
        logger.debug('Announce') { "Start" }
        3.times do |i|
          online_publish
          Kernel.sleep(3)
          logger.debug('Announce') { "announce #{i}" }
        end
        logger.debug('Announce') { 'Finish' }
      rescue StandardError => e
        with_backtrace(logger, e)
      end
      logger.debug('Announce') { "Thead end" }
    end
    logger.debug('Announce') { "Spawned Thread" }
  end

  def self.online
    instance.online
  end

  def online_message
    Messaging::Notification.new(topic: :system, name: :online)
  end

  def online_publish
    n = online_message
    LogActually.messaging.info(self.class) { "Publisher Ready Send." }
    # Publisher.send(n.topic, n)
    Publisher.send!(n)
  end

  private

  # @pverride
  def open_socket
    LogActually.messaging.info(self.class) { "Open Socket." }
    LogActually.messaging.debug(self.class) { "Socket: #{Thread.current}" }
    LogActually.messaging.debug(self.class) { "Role: #{role}" }
    LogActually.messaging.debug(self.class) { "URI: #{uri}" }
    context
    worker
    context.bind(role, uri)
  end

  def default_role
    DEFAULTS[:role]
  end

  def default_protocol
    DEFAULTS[:protocol]
  end

  def default_address
    DEFAULTS[:address]
  end

  def default_port
    DEFAULTS[:port]
  end
end
