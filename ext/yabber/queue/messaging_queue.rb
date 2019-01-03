# frozen_string_literal: true

require 'rbczmq'

# Comment
class MessagingContext
  include Singleton

  # attr_accessor :counter

  def self.context
    instance.context
  end

  def context
    @context ||= create_context
  end

  def create_context
    LogActually.messaging.debug(self.class) { 'Create Context.' }
    LogActually.messaging.debug(self.class) { "Context: #{Thread.current}" }
    ZMQ::Context.new
  end
end

# Comment
class MessagingQueue
  include Singleton
  include LogActually::ErrorOutput
  attr_writer :role, :protocol, :address, :port
  # attr_accessor :counter

  def destroy
    context.destroy
  end

  def logger
    LogActually.messaging
  end

  def close
    LogActually.messaging.warn(self.class) { '#close' }
    result = socket.close
    LogActually.messaging.warn(self.class) { "socket.close => #{result}" }
    @socket = nil
  end

  def sanitize(string)
    string.to_s
  end

  def self.setup
    instance.setup
    instance
  end

  # def setup
  #   3.times { |i| announce }
  # end

  private

  def context
    @context ||= create_context
  end

  def create_context
    MessagingContext.context
  end

  def socket?
    @socket ? true : false
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
