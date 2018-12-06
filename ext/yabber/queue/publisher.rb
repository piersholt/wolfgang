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
    instance.sendm(topic)
    instance.send(payload)
  end

  private

  # @pverride
  def open_socket
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
