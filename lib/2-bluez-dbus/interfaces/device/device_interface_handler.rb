# frozen_string_literal: true

# Comment
class DeviceInterfaceHandler
  include Singleton
  include SignalDelegate

  attr_accessor :mq

  # @override SignalDelegate
  def properties_changed(signal)
    if signal.only?('Connected') && signal.connected?
      device_connected
    elsif signal.only?('Connected') && signal.disconnected?
      device_disconnected
    end
  end

  def interface_called(event)
    if event.method == :connect
      device_connecting
    elsif event.method == :disconnect
      device_disconnecting
    end
  end

  def responsibility
    BLUEZ_DEVICE
  end

  # def responsible?(method, object)
  #   respond_to?(method)
  # end

  private

  def device_connecting
    LOGGER.unknown(self.class) { 'Device connecting...' }
    n = Notification.new(:device, :device_connecting)
    mq.push(n)
  end

  def device_disconnecting
    LOGGER.unknown(self.class) { 'Device disconnecting...' }
    n = Notification.new(:device, :device_disconnecting)
    mq.push(n)
  end

  def device_connected
    LOGGER.unknown(self.class) { 'Device connected!' }
    n = Notification.new(:device, :device_connected)
    mq.push(n)
  end

  def device_disconnected
    LOGGER.unknown(self.class) { 'Device disconnected!' }
    n = Notification.new(:device, :device_disconnected)
    mq.push(n)
  end
end
