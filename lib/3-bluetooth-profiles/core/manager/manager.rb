# frozen_string_literal: true

module Core
  # Comment
  class Manager
    # extend Forwardable
    # include State
    # include Attributes
    include SignalHandling
    include Notifications
    # include Commands
    include LogActually::ErrorOutput

    # def_delegators :object, *BluezDevice::Methods.instance_methods

    # attr_reader :object

    def logger
      LogActually.core
    end

    def devices
      @devices ||= {}
    end

    def device(nickname)
      found_device = devices.find do |_, device|
        if device.alias == nickname
          true
        elsif nickname.is_a?(Symbol) && device.alias == nickname.to_s
          true
        elsif nickname.is_a?(Symbol) && device.alias.downcase == nickname.downcase.to_s
          true
        else
          false
        end
      end
      return false unless found_device
      found_device[1]
    end

    alias d device

    # def initialize
    #   @connected = nil
    # end

    # def initialize(player_path)
    #   @object = BluezDBus.service.player(player_path)
    # end
  end
end
