# frozen_string_literal: true

module Messaging
  module API
    # Comment
    module Manager
      include Constants

      def device_list
        thy_will_be_done!(MANAGER, DEVICES)
      end

      # def device_list?
      #   so?(MANAGER, DEVICES)
      # end

      def connect(device_address)
        thy_will_be_done!(MANAGER, CONNECT, address: device_address)
      end

      def disconnect(device_address)
        thy_will_be_done!(MANAGER, DISCONNECT, address: device_address)
      end
    end
  end
end
