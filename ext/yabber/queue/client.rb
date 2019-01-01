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

  def worker_process(thread_queue)
    i = 1
    loop do
      string = pop(i, thread_queue)
      forward_to_zeromq(string)
      i += 1
      # Kernel.sleep(3)
    end
  end

  def pop(i, thread_queue)
    logger.debug(self.class) { "Worker waiting (Next: Message ID: #{i})" }
    popped_messsage = thread_queue.pop
    # popped_messsage.id = i
    # # popped_messsage.session = Time.now.strftime("%j_%H_%M")
    # message_hash = { topic: topic(popped_messsage),
    #                  payload: payload(popped_messsage) }

    logger.debug(self.class) { "Message ID: #{i} => #{popped_messsage}" }
    popped_messsage
  rescue StandardError => e
    logger.error(self.class) { e }
  end

  def forward_to_zeromq(string)
    LogActually.messaging.debug(self.class) { "#forward_to_zeromq(#{string})" }
    result = send(string)
    LogActually.messaging.debug(self.class) { "send(#{string}) => #{result}" }
    reply = recv
    LogActually.messaging.debug(self.class) { "reply => #{reply}" }
    # raise StandardError, 'Failed send?' unless result_topic && result_payload
    # self.counter = counter + 1
  end

  private

  # @pverride
  def open_socket
    LogActually.messaging.debug(self.class) { "Open Socket." }
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
