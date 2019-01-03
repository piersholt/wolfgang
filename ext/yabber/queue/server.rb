# frozen_string_literal: true

# Comment
class Server < MessagingQueue
  extend Forwardable
  # include ThreadSafe

  def_delegators :socket, :recv, :send
  attr_reader :thread

  DEFAULTS = {
    role: :REP,
    protocol: 'tcp',
    address: '*',
    port: '5557'
  }.freeze

  # def self.send!(message)
  #   instance.send!(message)
  # end
  #
  # def send!(message)
  #   queue_message(message)
  # end

  def self.start
    instance.start
  end

  def start
    logger.debug(self.class) { "#test" }
    @thread = Thread.new do
      begin
        i = 0
        logger.debug(self.class) { "enter loop..." }
        while i < 50
          message = recv
          logger.debug(self.class) { "recv => #{message}" }
          result = send('pong')
          logger.debug(self.class) { "send('pong') => #{result}" }
          i += 1
        end
      rescue StandardError => e
        logger.error(self.class) { e }
      end
      logger.warn(self.class) { 'Test thread ending?' }
    end
  end

  private

  # @pverride
  def open_socket
    LogActually.messaging.debug(self.class) { "Open Socket." }
    LogActually.messaging.debug(self.class) { "Socket: #{Thread.current}" }
    LogActually.messaging.debug(self.class) { "Role: #{role}" }
    LogActually.messaging.debug(self.class) { "URI: #{uri}" }
    # context
    # worker
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

  def payload(message)
    message.to_yaml
  end
end
