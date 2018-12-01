# frozen_string_literal: true

class DeviceInterfaceHandler
  include Singleton
  include PropertiesHandler

  attr_accessor :mq

  ASSOCIATED_INTERFACE = BLUEZ_DEVICE

  def take_responsibility(signal)
    if signal.only?('Connected') && signal.connected?
      device_connected
    elsif signal.only?('Connected') && signal.disconnected?
      device_disconnected
    end
  end

  private

  def device_connected
    LOGGER.unknown('Device Handler') { 'Device connected!' }
    n = Notification.new(:device, :device_connected)
    mq.push(n)
  end

  def device_disconnected
    LOGGER.unknown('Device Handler') { 'Device disconnected!' }
    n = Notification.new(:device, :device_disconnected)
    mq.push(n)
  end

  def responsibility
    ASSOCIATED_INTERFACE
  end
end
