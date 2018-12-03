# frozen_string_literal: true

# Comment
module BluezDevice
  include InterfaceConstants

  # Interface specific callback
  # def connect_called(listener, method)
  #   callback = on_call_block(listener, method)
  #   device.on_call(:connect, callback)
  # end

  # METHODS

  def connect
    call_callback = fetch_callback(:connect)
    call_callback.call(BLUEZ_DEVICE, :connect)
    device_interface.Connect(&default_callback)
  end

  def disconnect
    call_callback = fetch_callback(:disconnect)
    call_callback.call(BLUEZ_DEVICE, :disconnect)
    device_interface.Disconnect(&default_callback)
  end

  # @argument: uuid String
  def connect_profile(uuid); end

  # @argument: uuid String
  def disconnect_profile(uuid); end

  def pair; end

  def cancel_pairing; end

  # Properties

  def connected?
    device_property('Connected')
  end

  def paired?
    device_property('Paired')
  end

  def name
    device_property('Name')
  end

  def address
    device_property('Address')
  end

  def klass
    device_property('Class')
  end

  def uuids
    device_property('UUIDs')
  end

  def trusted?
    device_property('Trusted')
  end

  def blocked?
    device_property('Blocked')
  end

  def alias
    device_property('Alias')
  end

  def adapter
    device_property('Adapter')
  end

  def device
    self.default_iface = BLUEZ_DEVICE
    @selected_interface = BLUEZ_DEVICE
    self
  end

  private

  def device_interface
    interface(BLUEZ_DEVICE)
  end

  def device_property(property)
    property_get(BLUEZ_DEVICE, property)
  end
end
