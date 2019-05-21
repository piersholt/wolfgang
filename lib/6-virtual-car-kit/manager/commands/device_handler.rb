# frozen_string_literal: true

# Comment
class DeviceHandler
  include Singleton
  include NotificationDelegate
  include Messaging::Constants

  attr_accessor :manager

  def responsibility
    MANAGER
  end

  def take_responsibility(command)
    logger.debug(self.class) { "#take_responsibility(#{command})" }
    case command.name
    when CONNECT
      connect(command.properties)
    when DISCONNECT
      disconnect(command.properties)
    when DEVICES
      devices
    else
      not_handled(command)
    end
  rescue StandardError => e
    logger.error(self.class) { e }
    e.backtrace.each { |l| logger.error(l) }
  end

  def logger
    LogActually.commands
  end

  def connect(address:)
    logger.info(self.class) { "#{CONNECT}: #{address}" }
    manager.connect(address)
  end

  def disconnect(address:)
    logger.info(self.class) { "#{DISCONNECT}: #{address}" }
    manager.disconnect(address)
  end

  def devices
    logger.info(self.class) { DEVICES }
    manager.devices.each do |device_id, device_object|
      n = Messaging::Notification.new(topic: MANAGER, name: :new_device, properties: device_object.attributes)
      Publisher.send!(n)
    end
  end
end