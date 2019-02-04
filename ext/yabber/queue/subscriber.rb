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
    topic = instance.recv
    message = instance.recv
    # puts "#{message}\n"
    message
  rescue ZMQ::Socket => e
    LogActually.messaging.error(self) { "#{e}" }
    e.backtrace.each { |l| LogActually.messaging.error(l) }
    # binding.pry
  end

  def self.subscribe(topic = :broadcast)
    topic_string = topic.to_s
    topic_human = topic_string.empty? ? 'All Topics' : topic_string
    LogActually.messaging.info(self) { "Subscribe: #{topic_human}" }
    instance.subscribe(topic_string)
  end

  def self.pi
    # instance.close if instance.socket?
    instance.address = '192.168.1.107'
    subscribe('')
  end

  def self.local
    # close if socket?
    instance.address = 'localhost'
    subscribe('')
  end

  def self.mbp
    instance.address = '192.168.1.102'
    subscribe('')
  end

  # @override
  def setup(topic = :broadcast)
    super()
    topic = sanitize(topic)
    subscribe(topic)
  end

  private

  # @override
  def logger
    LogActually.subscriber
  end

  # @override
  def open_socket
    LogActually.messaging.info(self.class) { "Open Socket." }
    LogActually.messaging.debug(self.class) { "Open Socket: #{Thread.current}" }
    LogActually.messaging.debug(self.class) { "Role: #{role}" }
    LogActually.messaging.debug(self.class) { "URI: #{uri}" }
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
