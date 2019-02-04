# frozen_string_literal: true

# Comment
class Client < MessagingQueue
  extend Forwardable
  include ThreadSafe

  def_delegators :socket, :send, :recv

  DEFAULTS = {
    role: :REQ,
    protocol: 'tcp',
    address: 'localhost',
    port: '5557'
  }.freeze

  # @override ThreadSafe#queue_message
  def queue_message(string, callback)
    logger.debug(self.class) { 'Queue Message' }
    logger.debug(self.class) { "Queued Message: #{string}" }
    queue.push(string: string, callback: callback)
    true
  rescue StandardError => e
    with_backtrace(logger, e)
    false
  end

  def self.pi
    instance.address = '192.168.1.110'
  end

  private

  # @override ThreadSafe#pop
  def pop(i, thread_queue)
    logger.debug(self.class) { "Worker waiting (Next: Message ID: #{i})" }
    popped_messsage = thread_queue.pop
    logger.debug(self.class) { "Message ID: #{i} => #{popped_messsage}" }
    popped_messsage
  rescue StandardError => e
    logger.error(self.class) { e }
  end

  # @override ThreadSafe#worker_process
  def worker_process(thread_queue)
    i = 1
    loop do
      string_hash = pop(i, thread_queue)
      forward_to_zeromq(string_hash[:string], &string_hash[:callback])
      i += 1
      # Kernel.sleep(3)
    end
  end

  # @override ThreadSafe#forward_to_zeromq
  def forward_to_zeromq(string, &callback)
    timeout = 5
    3.times do
      LogActually.messaging.debug(self.class) { "#forward_to_zeromq(#{string})" }
      result = socket.send(string)
      LogActually.messaging.debug(self.class) { "send(#{string}) => #{result}" }
      raise StandardError, 'message failed to send...' unless result

      LogActually.messaging.debug(self.class) { "#select([socket], nil, nil, #{timeout})" }
      if select([socket], nil, nil, timeout)
        reply = socket.recv
        LogActually.messaging.debug(self.class) { "reply => #{reply}" }
        yield(reply, nil)
        return true
      else
         LogActually.messaging.warn(self.class) { 'Timeout! Retry!' }
         close
         socket
         timeout *= 2
      end
      LogActually.messaging.warn(self.class) { 'Down?' }
    end

    # raise StandardError, 'server down?'
    yield(nil, StandardError)

    # reply = recv
    # LogActually.messaging.debug(self.class) { "reply => #{reply}" }
    # callback.call(reply)
    # raise StandardError, 'Failed send?' unless result_topic && result_payload
    # self.counter = counter + 1
  end

  def select(read = [], write = [], error = [], timeout = nil)
    poller = ZMQ::Poller.new
    read&.each { |s| poller.register_readable(s) }
    write&.each { |s| poller.register_writable(s) }
    ready = poller.poll(timeout)
    logger.debug(self.class) { "ready => #{ready}" }
    logger.debug(self.class) { "ready ? true : false => #{ready ? true : false}" }
    case ready
    when 1
      [poller.readables, poller.writables, []] if ready
    when 0
      false
    end
  end

  # @pverride
  def open_socket
    LogActually.messaging.info(self.class) { 'Open Socket.' }
    LogActually.messaging.debug(self.class) { "Socket: #{Thread.current}" }
    LogActually.messaging.debug(self.class) { "Role: #{role}" }
    LogActually.messaging.debug(self.class) { "URI: #{uri}" }
    context
    # binding.pry
    queue
    # worker
    context.connect(role, uri)
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
