# frozen_string_literal: true

module Core
  # Comment
  class Device
    extend Forwardable
    include State
    include Attributes
    # include SignalHandling
    # include Notifications
    # include Commands

    def_delegators :object, *BluezDevice::Methods.instance_methods

    attr_reader :object

    def logger
      LogActually.core
    end

    # def initialize
    #   @connected = nil
    # end

    def initialize(device_path)
      @object = BluezDBus.service.device(device_path)
      @methods = BluezDevice::Methods.instance_methods
    end
  end
end
