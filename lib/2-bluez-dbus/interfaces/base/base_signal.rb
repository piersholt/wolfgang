# frozen_string_literal: true

# Comment
class InterfaceCalled
  attr_reader :interface, :method
  alias target interface

  def initialize(interface_name, method_name)
    @interface = interface_name
    @method = method_name
  end

  def this_interface?(that_interface)
    interface == that_interface
  end
end

# Comment
class BaseSignal
  include ObjectConstants
  include ObjectHelpers

  attr_reader :sender, :path, :interface, :member
  alias_method :signal, :member

  def initialize(sender: 'Bluez', path: 'whatever', interface:, member: )
    @sender = sender
    @interface = interface
    @member = member
    @path = path
  end

  def filter_non_bluez_hash(interface_hash)
    result = interface_hash.find_all { |name, props| name.include?('bluez') }
    return result if result.empty?
    result.to_h
  end

  def filter_non_bluez_array(interface_name_array)
    interface_name_array.find_all { |str| str.include?('bluez') }
  end
end
