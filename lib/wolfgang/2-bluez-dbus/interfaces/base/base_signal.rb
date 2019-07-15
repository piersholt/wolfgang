# frozen_string_literal: true

module Wolfgang
  # BaseSignal
  class BaseSignal
    include ObjectConstants
    include ObjectHelpers

    SIGNAL_SENDER = 'Bluez'
    SIGNAL_PATH   = 'whatever'
    FILTER_BLUEZ  = 'bluez'

    attr_reader :sender, :path, :interface, :member
    alias signal member

    def initialize(sender: SIGNAL_SENDER, path: SIGNAL_PATH, interface:, member: )
      @sender = sender
      @interface = interface
      @member = member
      @path = path
    end

    def filter_non_bluez_hash(interface_hash)
      result = interface_hash.find_all do |name, _|
        name.include?(FILTER_BLUEZ)
      end
      return result if result.empty?
      result.to_h
    end

    def filter_non_bluez_array(interface_name_array)
      interface_name_array.find_all { |str| str.include?(FILTER_BLUEZ) }
    end
  end
end
