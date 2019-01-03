# frozen_string_literal: true

module Messaging
  module API
    # Comment
    module Manager
      include Constants

      def connect
        thy_will_be_done!(MANAGER, CONNECT, alias: 'P7')
      end

      def disconnect
        thy_will_be_done!(MANAGER, DISCONNECT)
      end
    end
  end
end
