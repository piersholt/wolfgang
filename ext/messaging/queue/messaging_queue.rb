# frozen_string_literal: true

require 'rbczmq'

# Comment
class MessagingContext
  include Singleton

  def self.context
    instance.context
  end

  def context
    @context ||= ZMQ::Context.new
  end
end

# Comment
class MessagingQueue
  include Singleton
  attr_writer :role, :protocol, :address, :port

  def destroy
    context.destroy
  end

  def close
    socket.close
    @socket = nil
  end

  def sanitize(string)
    string.to_s
  end

  def self.setup
    instance.setup
    instance
  end

  def setup
    socket
  end

  private

  def context
    @context ||= MessagingContext.context
  end

  def socket
    @socket ||= open_socket
  end

  def role
    @role ||= default_role
  end

  def protocol
    @protocol ||= default_protocol
  end

  def address
    @address ||= default_address
  end

  def port
    @port ||= default_port
  end

  def uri(t_protocol = protocol, t_address = address, t_port = port)
    "#{t_protocol}://#{t_address}:#{t_port}"
  end
end
