# frozen_string_literal: true

# Comment
class Publisher < MessagingQueue
  extend Forwardable
  include ManageableThreads
  include ThreadSafe
  include Announce
  extend Announce

  def_delegators :socket, :send, :sendm

  DEFAULTS = {
    role: :PUB,
    protocol: 'tcp',
    address: '*',
    port: '5556'
  }.freeze

  def send!(message)
    queue_message(message)
  end

  def self.send!(message)
    instance.send!(message)
  end

  def self.online(who_am_i)
    instance.online(who_am_i)
  end

  private

  # @pverride
  def open_socket
    LogActually.messaging.debug(self.class) { "Open Socket." }
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

  def topic(message)
    message.topic
  end

  def payload(message)
    message.to_yaml
  end
end
