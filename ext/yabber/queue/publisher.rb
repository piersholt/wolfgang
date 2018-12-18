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

  def self.send(topic, payload)
    topic = instance.sanitize(topic)
    payload = instance.sanitize(payload)
    LOGGER.debug(topic)
    LOGGER.debug(payload)
    # LOGGER.debug(counter)
    result_topic = instance.sendm(topic)
    result_payload = instance.send(payload)
    raise StandardError, 'Failed send?' unless result_topic && result_payload
    # self.counter = counter + 1
  end

  def self.ready
    instance.ready
  end

  def ready
    n = Messaging::Notification.new(topic: :system, name: :online)
    LOGGER.info(self.class) { "Publisher Ready Send." }
    Publisher.send(n.topic, n)
  end

  private

  # @pverride
  def open_socket
    # self.counter = 0
    LOGGER.info(self.class) { "Open Socket." }
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
