# frozen_string_literal: true

# Comment
class Subscriber < MessagingQueue
  extend Forwardable

  def_delegators :socket, :recv, :subscribe

  DEFAULTS = {
    role: :SUB,
    protocol: 'tcp',
    address: 'localhost',
    port: '5556'
  }.freeze

  def self.recv
    _ = instance.recv
    message = instance.recv
    puts "#{message}"
    message
  end

  def self.subscribe(topic = :broadcast)
    instance.subscribe(topic.to_s)
  end

  def self.pi
    instance.address = '192.168.1.105'
  end

  def self.local
    instance.address = 'localhost'
  end

  # @override
  def setup(topic = :broadcast)
    super()
    topic = sanitize(topic)
    subscribe(topic)
  end

  private

  # @override
  def open_socket
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
